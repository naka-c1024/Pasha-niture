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
)

from openapi_server.models.extra_models import TokenModel  # noqa: F401
from openapi_server.models.furniture_list_response import FurnitureListResponse
from openapi_server.models.furniture_response import FurnitureResponse
from openapi_server.models.register_furniture_request import RegisterFurnitureRequest


router = APIRouter()

ns_pkg = openapi_server.impl
for _, name, _ in pkgutil.iter_modules(ns_pkg.__path__, ns_pkg.__name__ + "."):
    importlib.import_module(name)


@router.delete(
    "/furniture/{furniture_id}",
    responses={
        200: {"description": "Furniture deleted successfully"},
        400: {"description": "バリデーションエラー"},
    },
    tags=["Furniture"],
    summary="Delete furniture",
    response_model_by_alias=True,
)
async def furniture_furniture_id_delete(
    furniture_id: int = Path(..., description=""),
) -> None:
    ...


@router.get(
    "/furniture/{furniture_id}",
    responses={
        200: {"model": FurnitureResponse, "description": "Furniture details retrieved successfully"},
        400: {"description": "バリデーションエラー"},
    },
    tags=["Furniture"],
    summary="Get furniture details",
    response_model_by_alias=True,
)
async def furniture_furniture_id_get(
    furniture_id: int = Path(..., description=""),
) -> FurnitureResponse:
    ...


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
) -> FurnitureListResponse:
    ...


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
    user_id: int = Query(None, description="", alias="userId"),
    register_furniture_request: RegisterFurnitureRequest = Body(None, description=""),
) -> FurnitureResponse:
    ...