# coding: utf-8

from typing import Dict, List  # noqa: F401
import importlib
import pkgutil

from openapi_server.apis.furniture_api_base import BaseFurnitureApi
import openapi_server.impl

from fastapi import (  # noqa: F401
    APIRouter,
    Body,
    Cookie,
    Depends,
    Form,
    Header,
    Path,
    Query,
    Response,
    Security,
    status,
    UploadFile,
)

from openapi_server.models.extra_models import TokenModel  # noqa: F401
from openapi_server.models.error_response import ErrorResponse
from openapi_server.models.furniture_describe_response import FurnitureDescribeResponse
from openapi_server.models.furniture_list_response import FurnitureListResponse
from openapi_server.models.furniture_recommend_response import FurnitureRecommendResponse
from openapi_server.models.furniture_response import FurnitureResponse

from openapi_server.impl.furniture_api_impl import FurnitureApiImpl
from sqlalchemy.ext.asyncio import AsyncSession
from openapi_server.db import get_db

impl = FurnitureApiImpl()

router = APIRouter()

ns_pkg = openapi_server.impl
for _, name, _ in pkgutil.iter_modules(ns_pkg.__path__, ns_pkg.__name__ + "."):
    importlib.import_module(name)


@router.post(
    "/furniture/describe",
    responses={
        200: {"model": FurnitureDescribeResponse, "description": "Furniture described successfully"},
        400: {"model": ErrorResponse, "description": "validation error"},
    },
    tags=["Furniture"],
    summary="Generate furniture description",
    response_model_by_alias=True,
)
async def furniture_describe_post(
    image: UploadFile = Form(None, description=""),
) -> FurnitureDescribeResponse:
    return await impl.furniture_describe_post(image)


@router.delete(
    "/furniture/{furniture_id}",
    responses={
        200: {"description": "Furniture deleted successfully"},
        400: {"model": ErrorResponse, "description": "validation error"},
    },
    tags=["Furniture"],
    summary="Delete furniture",
    response_model_by_alias=True,
)
async def furniture_furniture_id_delete(
    furniture_id: int = Path(..., description=""),
    db: AsyncSession = Depends(get_db),
) -> None:
    return await impl.furniture_furniture_id_delete(furniture_id, db)


# パスマッチの順番のために"/furniture/{furniture_id}"よりも前に書いている
@router.get(
    "/furniture/personal_products",
    responses={
        200: {"model": FurnitureListResponse, "description": "Furniture list retrieved successfully"},
    },
    tags=["Furniture"],
    summary="Get list of Personal furniture by user_id",
    response_model_by_alias=True,
)
async def furniture_personal_products_get(
    user_id: int = Query(None, description="", alias="user_id"),
    db: AsyncSession = Depends(get_db),
) -> FurnitureListResponse:
    return await impl.furniture_personal_products_get(user_id, db)


@router.get(
    "/furniture/{furniture_id}",
    responses={
        200: {"model": FurnitureResponse, "description": "Furniture details retrieved successfully"},
        400: {"model": ErrorResponse, "description": "validation error"},
    },
    tags=["Furniture"],
    summary="Get furniture details",
    response_model_by_alias=True,
)
async def furniture_furniture_id_get(
    furniture_id: int = Path(..., description=""),
    user_id: int = Query(None, description="", alias="user_id"),
    db: AsyncSession = Depends(get_db),
) -> FurnitureResponse:
    return await impl.furniture_furniture_id_get(furniture_id, user_id, db)


@router.get(
    "/furniture",
    responses={
        200: {"model": FurnitureListResponse, "description": "Furniture list retrieved successfully"},
    },
    tags=["Furniture"],
    summary="Get list of furniture",
    response_model_by_alias=True,
)
async def furniture_get(
    user_id: int = Query(None, description="", alias="user_id"),
    category: int = Query(None, description="カテゴリコード, URL(https://github.com/naka-c1024/Pasha-niture/blob/main/client/app/lib/Domain/constants.dart)", alias="category"),
    keyword: str = Query(None, description="検索キーワード, スペース区切りで複数指定可", alias="keyword"),
    db: AsyncSession = Depends(get_db),
) -> FurnitureListResponse:
    return await impl.furniture_get(user_id, category, keyword, db)


@router.post(
    "/furniture",
    responses={
        200: {"model": FurnitureResponse, "description": "Furniture registered successfully"},
    },
    tags=["Furniture"],
    summary="Register new furniture",
    response_model_by_alias=True,
)
async def furniture_post(
    user_id: int = Form(..., description=""),
    product_name: str = Form(..., description=""),
    image: UploadFile = Form(..., description=""),
    description: str = Form(..., description=""),
    height: float = Form(..., description=""),
    width: float = Form(..., description=""),
    depth: float = Form(..., description=""),
    category: int = Form(..., description=""),
    color: int = Form(..., description="色コード, URL(https://github.com/naka-c1024/Hack_U_Team1/blob/main/client/app/lib/constants.dart)"),
    start_date: str = Form(None, description=""),
    end_date: str = Form(None, description=""),
    trade_place: str = Form(..., description=""),
    condition: int = Form(..., description=""),
    db: AsyncSession = Depends(get_db),
) -> FurnitureResponse:
    return await impl.furniture_post(
        user_id,
        product_name,
        image,
        description,
        height,
        width,
        depth,
        category,
        color,
        start_date,
        end_date,
        trade_place,
        condition,
        db
    )


@router.post(
    "/furniture/recommend",
    responses={
        200: {"model": FurnitureRecommendResponse, "description": "Furniture recommended successfully"},
        400: {"model": ErrorResponse, "description": "validation error"},
    },
    tags=["Furniture"],
    summary="Recommend furniture",
    response_model_by_alias=True,
)
async def furniture_recommend_post(
    room_photo: UploadFile = Form(..., description=""),
    category: int = Form(..., description="カテゴリコード(https://github.com/naka-c1024/Pasha-niture/blob/main/client/app/lib/Domain/constants.dart)"),
    db: AsyncSession = Depends(get_db),
) -> FurnitureRecommendResponse:
    return await impl.furniture_recommend_post(room_photo, category, db)
