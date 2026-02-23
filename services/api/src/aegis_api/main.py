from fastapi import FastAPI
from fastapi.routing import APIRoute

from api.main import api_router

app = FastAPI(
    title="Aegis API",
    version="0.1.0"
)

app.include_router(api_router, prefix="/api")