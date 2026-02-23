from __future__ import annotations

import os
from typing import Any, Dict, Optional

import httpx
from fastapi import HTTPException

SUPABASE_URL = os.environ["SUPABASE_URL"].rstrip("/")
SUPABASE_ANON_KEY = os.environ["SUPABASE_ANON_KEY"]

async def _request(method: str, path: str, token: str, json: Optional[Dict[str, Any]] = None) -> Any:
    url = f"{SUPABASE_URL}/rest/v1/{path.lstrip('/')}"
    headers = {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json",
        "Prefer": "return=representation",
    }

    async with httpx.AsyncClient(timeout=20) as client:
        resp = await client.request(method, url, headers=headers, json=json)

    if resp.status_code >= 400:
        raise HTTPException(status_code=resp.status_code, detail=resp.text)

    return resp.json() if resp.text else None

async def postgrest_insert_profile(token: str, profile: Dict[str, Any]) -> Optional[Dict[str, Any]]:
    rows = await _request("POST", "profiles", token, json=profile)
    if isinstance(rows, list) and len(rows) > 0:
        return rows[0]
    return None

async def postgrest_select_profile(token: str, user_id: str) -> Optional[Dict[str, Any]]:
    rows = await _request("GET", f"profiles?id=eq.{user_id}&select=*", token)
    if isinstance(rows, list) and len(rows) > 0:
        return rows[0]
    return None