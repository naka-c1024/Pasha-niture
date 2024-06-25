# coding: utf-8

"""
    家具マッチングサービス

    画像によるレコメンド機能を添えて

    The version of the OpenAPI document: 1.0.0
    Generated by OpenAPI Generator (https://openapi-generator.tech)

    Do not edit the class manually.
"""  # noqa: E501


from __future__ import annotations
import pprint
import re  # noqa: F401
import json




from datetime import datetime
from pydantic import BaseModel, ConfigDict, Field, StrictInt, StrictStr
from typing import Any, ClassVar, Dict, List, Optional
try:
    from typing import Self
except ImportError:
    from typing_extensions import Self

class ChatResponse(BaseModel):
    """
    ChatResponse
    """ # noqa: E501
    chat_id: Optional[StrictInt] = None
    sender_id: Optional[StrictInt] = None
    receiver_id: Optional[StrictInt] = None
    message: Optional[StrictStr] = None
    send_date_time: Optional[datetime] = Field(default=None, description="メッセージ送信日時, 日付は日本標準時, ISO 8601形式")
    __properties: ClassVar[List[str]] = ["chat_id", "sender_id", "receiver_id", "message", "send_date_time"]

    model_config = {
        "populate_by_name": True,
        "validate_assignment": True,
        "protected_namespaces": (),
        "from_attributes": True,
    }


    def to_str(self) -> str:
        """Returns the string representation of the model using alias"""
        return pprint.pformat(self.model_dump(by_alias=True))

    def to_json(self) -> str:
        """Returns the JSON representation of the model using alias"""
        # TODO: pydantic v2: use .model_dump_json(by_alias=True, exclude_unset=True) instead
        return json.dumps(self.to_dict())

    @classmethod
    def from_json(cls, json_str: str) -> Self:
        """Create an instance of ChatResponse from a JSON string"""
        return cls.from_dict(json.loads(json_str))

    def to_dict(self) -> Dict[str, Any]:
        """Return the dictionary representation of the model using alias.

        This has the following differences from calling pydantic's
        `self.model_dump(by_alias=True)`:

        * `None` is only added to the output dict for nullable fields that
          were set at model initialization. Other fields with value `None`
          are ignored.
        """
        _dict = self.model_dump(
            by_alias=True,
            exclude={
            },
            exclude_none=True,
        )
        return _dict

    @classmethod
    def from_dict(cls, obj: Dict) -> Self:
        """Create an instance of ChatResponse from a dict"""
        if obj is None:
            return None

        if not isinstance(obj, dict):
            return cls.model_validate(obj)

        _obj = cls.model_validate({
            "chat_id": obj.get("chat_id"),
            "sender_id": obj.get("sender_id"),
            "receiver_id": obj.get("receiver_id"),
            "message": obj.get("message"),
            "send_date_time": obj.get("send_date_time")
        })
        return _obj
