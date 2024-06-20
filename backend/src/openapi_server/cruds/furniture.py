from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from sqlalchemy.engine import Result
from sqlalchemy.sql import or_

from typing import List, Tuple, Optional
from datetime import datetime

import openapi_server.db_model.tables as db_model
from openapi_server.models.register_furniture_request import RegisterFurnitureRequest
from openapi_server.models.furniture_response import FurnitureResponse
from openapi_server.models.furniture_list_response import FurnitureListResponse
from openapi_server.models.furniture_list_request import FurnitureListRequest

from openapi_server.cruds.favorite import get_is_favorite
from openapi_server.cruds.user_api import get_user

async def create_furniture(
        db: AsyncSession,
        user_id: int,
        product_name: str,
        image: str,
        description: str,
        height: float,
        width: float,
        depth: float,
        category: int,
        color: int,
        condition: int,
        trade_place: str,
        start_date: Optional[str] = None,
        end_date: Optional[str] = None,
    ) -> FurnitureResponse:
    # SQLAlchemyは、str型を自動的にDBのDate型に変換することはないため、明示的に変換する
    start_date_parsed = datetime.strptime(start_date, "%Y-%m-%d").date() if start_date else None
    end_date_parsed = datetime.strptime(end_date, "%Y-%m-%d").date() if end_date else None
    
    furniture = db_model.Furniture(
        user_id=user_id,
        product_name=product_name,
        image=image,
        description=description,
        height=height,
        width=width,
        depth=depth,
        category=category,
        color=color,
        condition=condition,
        start_date=start_date_parsed,
        end_date=end_date_parsed,
        trade_place=trade_place,
    )

    db.add(furniture)
    await db.commit()
    await db.refresh(furniture)
    
    # furniture.user_idからusernameとareaを取得
    user = await get_user(db, furniture.user_id)
    if user is None:
        return None
    
    return FurnitureResponse(
        furniture_id=furniture.furniture_id,
        image=furniture.image,  # 画像データではなくURIであることに注意
        area=user.area,
        username=user.username,
        product_name=furniture.product_name,
        description=furniture.description,
        size=f"{furniture.height} {furniture.width} {furniture.depth}",
        category=furniture.category,
        color=furniture.color,
        condition=furniture.condition,
        is_sold=furniture.is_sold,
        start_date=furniture.start_date,
        end_date=furniture.end_date,
        trade_place=furniture.trade_place,
        is_favorite=False,
    )

async def get_furniture(db: AsyncSession, furniture_id: int, user_id: int) -> Optional[FurnitureResponse]:
    result: Result = await db.execute(
        select(db_model.Furniture).where(db_model.Furniture.furniture_id == furniture_id)
    )
    furniture: Optional[Tuple[db_model.Furniture]] = result.first()
    if furniture is None:
        return None
    else:
        furniture = furniture[0]
    
    # furniture.user_idからusernameとareaを取得
    user = await get_user(db, furniture.user_id)
    if user is None:
        return None
    
    # furniture.furniture_idとis_favoriteを取得
    is_favorite = await get_is_favorite(db, furniture_id, user_id)
    
    return FurnitureResponse(
        furniture_id=furniture.furniture_id,
        image=furniture.image,  # 画像データではなくURIであることに注意
        area=user.area,
        username=user.username,
        product_name=furniture.product_name,
        description=furniture.description,
        size=f"{furniture.height} {furniture.width} {furniture.depth}",
        category=furniture.category,
        color=furniture.color,
        condition=furniture.condition,
        is_sold=furniture.is_sold,
        start_date=furniture.start_date,
        end_date=furniture.end_date,
        trade_place=furniture.trade_place,
        is_favorite=is_favorite,
    )

async def get_furniture_list(db: AsyncSession, user_id: int, keyword: Optional[str]) -> FurnitureListResponse:
    query = select(db_model.Furniture)

    if keyword:
        conditions = []
        for word in keyword.split():
            conditions.append(db_model.Furniture.product_name.like(f'%{word}%'))
            conditions.append(db_model.Furniture.description.like(f'%{word}%'))

        query = query.where(or_(*conditions))
    
    result: Result = await db.execute(query)
    furniture_list = result.scalars().all()

    if furniture_list is None:
        return None
    
    furniture_list_res = []
    for furniture in furniture_list:
        
        # furniture.user_idからusernameとareaを取得
        user = await get_user(db, furniture.user_id)
        if user is None:
            return None
        
        # furniture.furniture_idとis_favoriteを取得
        is_favorite = await get_is_favorite(db, furniture.furniture_id, user_id)
        
        furniture_list_res.append(
            FurnitureResponse(
                furniture_id=furniture.furniture_id,
                image=furniture.image,  # 画像データではなくURIであることに注意
                area=user.area,
                username=user.username,
                product_name=furniture.product_name,
                description=furniture.description,
                size=f"{furniture.height} {furniture.width} {furniture.depth}",
                category=furniture.category,
                color=furniture.color,
                condition=furniture.condition,
                is_sold=furniture.is_sold,
                start_date=furniture.start_date,
                end_date=furniture.end_date,
                trade_place=furniture.trade_place,
                is_favorite=is_favorite,
            )
        )

    return FurnitureListResponse(furniture=furniture_list_res)


async def delete_furniture(db: AsyncSession, furniture_id: int) -> Optional[str]:
    result: Result = await db.execute(
        select(db_model.Furniture).where(db_model.Furniture.furniture_id == furniture_id)
    )
    furniture: Optional[db_model.Furniture] = result.scalar_one_or_none()
    if furniture is None:
        return "Furniture not found"
    
    # 取引履歴がある場合は削除しない
    result: Result = await db.execute(
        select(db_model.Trades).where(db_model.Trades.furniture_id == furniture_id)
    )
    if result.first():
        return "Furniture has trade history and cannot be deleted"
    
    image_filepath = furniture.image
    
    await db.delete(furniture)
    await db.commit()

    return image_filepath
