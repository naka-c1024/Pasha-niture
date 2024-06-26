import base64
import uuid
from typing import Optional, List
from fastapi import HTTPException, UploadFile
from sqlalchemy.ext.asyncio import AsyncSession

from openapi_server.apis.furniture_api_base import BaseFurnitureApi
from openapi_server.models.furniture_list_response import FurnitureListResponse
from openapi_server.models.furniture_recommend_response import FurnitureRecommendResponse
from openapi_server.models.furniture_response import FurnitureResponse
from openapi_server.models.furniture_describe_response import FurnitureDescribeResponse

import openapi_server.cruds.furniture as furniture_crud
from openapi_server.impl.common import read_image_file, write_image_file
from openapi_server.object_storage.minio import minio_client
from openapi_server.ai.furniture import FurnitureDescribe, FurnitureRecommendation


class FurnitureApiImpl(BaseFurnitureApi):
    async def furniture_describe_post(
        self,
        image: UploadFile,
    ) -> FurnitureDescribeResponse:
        response = await FurnitureDescribe().get_describe(image)
        return FurnitureDescribeResponse(**response)

    async def furniture_furniture_id_delete(
        self,
        furniture_id: int,
        db: AsyncSession,
    ) -> None:
        image_key, err_msg = await furniture_crud.delete_furniture(db, furniture_id)
        if err_msg:
            if err_msg == "Furniture not found":
                raise HTTPException(status_code=404, detail=err_msg)
            else:
                raise HTTPException(status_code=400, detail=err_msg)

        minio_client.delete_file(image_key)

    async def furniture_furniture_id_get(
        self,
        furniture_id: int,
        request_user_id: int,
        db: AsyncSession,
    ) -> FurnitureResponse:
        furniture = await furniture_crud.get_furniture(db, furniture_id, request_user_id)
        if furniture is None:
            raise HTTPException(status_code=404, detail="Furniture not found")
        await self._embed_image_data(furniture)
        return furniture

    async def furniture_get(
        self,
        request_user_id: int,
        category: Optional[int],
        keyword: Optional[str],
        db: AsyncSession,
    ) -> FurnitureListResponse:
        furniture_list = await furniture_crud.get_furniture_list(db, request_user_id, category, None, keyword)
        if not furniture_list.furniture:
            raise HTTPException(status_code=404, detail="Furniture not found")
        await self._embed_image_data_list(furniture_list.furniture)
        return furniture_list

    async def furniture_personal_products_get(
        self,
        user_id: int,
        db: AsyncSession,
    ) -> FurnitureListResponse:
        furniture_list = await furniture_crud.get_personal_furniture_list(db, user_id)
        if not furniture_list.furniture:
            raise HTTPException(status_code=404, detail="Furniture not found")
        await self._embed_image_data_list(furniture_list.furniture)
        return furniture_list

    async def furniture_post(
        self,
        user_id: int,
        product_name: str,
        image: UploadFile,
        description: str,
        height: float,
        width: float,
        depth: float,
        category: int,
        color: int,
        start_date: str,
        end_date: str,
        trade_place: str,
        condition: int,
        db: AsyncSession,
    ) -> FurnitureResponse:
        image_path = await self._save_image(user_id, product_name, image)
        furniture = await furniture_crud.create_furniture(
            db,
            user_id,
            product_name,
            image_path,
            description,
            height,
            width,
            depth,
            category,
            color,
            condition,
            trade_place,
            start_date,
            end_date,
        )
        if furniture is None:
            raise HTTPException(status_code=400, detail="Failed to create furniture")
        await self._embed_image_data(furniture, image_path)
        return furniture

    async def furniture_recommend_post(
        self,
        room_photo: UploadFile,
        category: int,
        db: AsyncSession,
    ) -> FurnitureRecommendResponse:
        response = await FurnitureRecommendation().get_recommend_color(room_photo)
        furniture_list = await furniture_crud.get_furniture_list(db, 1, category, response["color"], None)
        if furniture_list is not None:
            await self._embed_image_data_list(furniture_list.furniture)
        return FurnitureRecommendResponse(
            color           = response["color"],
            reason          = response["reason"],
            furniture_list  = furniture_list
        )

    async def _save_image(self, user_id: int, product_name: str, image: UploadFile) -> str:
        EXTENSION = "jpeg"  # 圧縮するためにjpeg形式にする
        QUALITY = 40  # 画像の圧縮率, 低いほど圧縮されるが画質が劣化する

        image_filename = f"userid{user_id}-{product_name}-{uuid.uuid4().hex}.{EXTENSION}"
        image_bytes = await image.read()
        return write_image_file(image_filename, image_bytes, QUALITY)

    async def _embed_image_data(self, furniture: FurnitureResponse, image_path: Optional[str] = None):
        try:
            if image_path:
                image_bytes = read_image_file(image_path)
            else:
                image_bytes = read_image_file(furniture.image)
            try:
                furniture.image = base64.b64encode(image_bytes).decode('utf-8')
            except Exception as e:
                # bytesがbase64に変換できない場合にエラーを返す
                raise HTTPException(status_code=500, detail="Failed to encode or decode image data")
        except FileNotFoundError:
            raise HTTPException(status_code=404, detail="Image file not found")

    async def _embed_image_data_list(self, furniture_list: List[FurnitureResponse]):
        for furniture in furniture_list:
            await self._embed_image_data(furniture)
