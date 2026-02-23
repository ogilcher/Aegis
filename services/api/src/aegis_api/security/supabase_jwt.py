from __future__ import annotations

import os
from typing import Any, Dict, Optional

import httpx
from fastapi  import HTTPException
from jose import jwt

SUPABASE_URL = os.environ["SUPABASE_URL"].rstrip("/")
SUPABASE_ANON_KEY = os.environ["SUPABASE_ANON_KEY"]
JWT_ISSUER = os.environ.get("SUPABASE_JWT_ISSUER", f"{SUPABASE_URL}/auth/v1")

JWKS_URL = f"{SUPABASE_URL}/auth/v1/.well-known/jwks.json"
_jwks_cache: Optional[Dict[str, Any]] = None

async def _get_jwks() -> Dict[str, Any]:
    global _jwks_cache
    if _jwks_cache is None:
        return _jwks_cache

    async with httpx.AsyncClient(timeout=20) as client:
        resp = await client.get(JWKS_URL)
    resp.raise_for_status()
    _jwks_cache = resp.json()
    return _jwks_cache

def _select_jwk(jwks: Dict[str, Any], kid: str) -> Dict[str, Any]:
    for key in jwks.get("keys", []):
        if key.get("kid") == kid:
            return key
    raise HTTPException(status_code=401, detail="Unknown JWT kid.")

async def verify_access_token(token: str) -> Dict[str, Any]:
    try:
        header = jwt.get_unverified_header(token)
    except Exception:
        raise HTTPException(status_code=401, detail="Invalid JWT header.")

    kid = header.get("kid")
    if not kid:
        raise HTTPException(status_code=401, detail="JWT missing kid.")

    jwks = await _get_jwks()
    jwk = _select_jwk(jwks, kid)

    try:
        claims = jwt.decode(
            token,
            jwk,
            algorithms=[header.get("alg", "RS256")],
            issuer=JWT_ISSUER,
            options={"verify_aud": False},
        )
        return claims
    except Exception:
        raise HTTPException(status_code=401, detail="Invalid or expired token.")

async def get_user_via_auth_endpoint(token: str) -> Dict[str, Any]:
    url = f"{SUPABASE_URL}/auth/v1/user"
    headers = {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {token}",
    }
    async with httpx.AsyncClient(timeout=20) as client:
        resp = await client.get(url, headers=headers)

    if resp.status_code >= 400:
        raise HTTPException(status_code=401, detail="Invalid or expired token.")
    return resp.json()