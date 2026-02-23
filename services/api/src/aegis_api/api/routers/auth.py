
from typing import Any, Dict, Optional

from fastapi import APIRouter, Header, HTTPException

from src.aegis_api.clients.supabase_rest import postgrest_insert_profile, postgrest_select_profile
from src.aegis_api.security.supabase_jwt import verify_access_token, get_user_via_auth_endpoint

router = APIRouter(prefix="/v1/auth", tags=["auth"])

def _bearer_token(authorization: Optional[str]) -> str:
    if not authorization or not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Missing Bearer token.")
    return authorization.removeprefix("Bearer ").strip()

@router.get("/me")
async def me(authorization: Optional[str] = Header(default=None)) -> Dict[str, Any]:
    """
    Validate Supabase access token and return caller identity.
    """
    token = _bearer_token(authorization)

    # Verify signature locally with JWKS
    claims = await verify_access_token(token)

    return {
        "user_id": claims.get("sub"),
        "email": claims.get("email"),
        "role": claims.get("role"),
        "claims": claims,
    }

@router.post("/provision-profile")
async def provision_profile(authorization: Optional[str] = Header(default=None)) -> Dict[str, Any]:
    """
    Ensure an application profile row exists for the authenticated user.
    Uses the USER JWT (Bearer token), so PostgREST + RLS enforce ownership.
    Idempotent: calling multiple times is safe.
    """
    token = _bearer_token(authorization)

    # Get authoritative user identity (works even if claims are missing email)
    user = await get_user_via_auth_endpoint(token)
    user_id = user.get("id")
    if not user_id:
        raise HTTPException(status_code=401, detail="Token valid but missing user id.")

    # Try create first (best effort). If it fails due to conflict, we'll select
    try:
        created = await postgrest_insert_profile(
            token=token,
            profile={
                "id": user_id,
                # Keep app-owned fields only
                "display_name": None,
            },
        )
        if created is not None:
            return {"status": "created", "profile": created}
    except HTTPException:
        # Fall through to select existing
        pass

    existing = await postgrest_select_profile(token=token, user_id=user_id)
    if existing is None:
        raise HTTPException(status_code=500, detail="Failed to provision profile.")
    return {"status": "exists", "profile": existing}