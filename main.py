from fastapi import FastAPI, Request
import httpx
import os
from fastapi.responses import JSONResponse

app = FastAPI()

# Целевой URL для пересылки (например, ваш другой сервер или сервис)
TARGET_WEBHOOK_URL = os.getenv("TARGET_WEBHOOK_URL", "https://ch46404.tw1.ru/tg/v1/webhook")

@app.post("/webhook")
async def handle_webhook(request: Request):
    try:
        # 1. Получаем данные от Telegram
        data = await request.json()
        print("Получено от Telegram:", data)  # Для отладки

        # 2. Пересылаем данные на целевой вебхук
        async with httpx.AsyncClient() as client:
            response = await client.post(
                TARGET_WEBHOOK_URL,
                json=data,
                headers={"Content-Type": "application/json"},
                timeout=10.0
            )
            response.raise_for_status()  # Проверяем успешность ответа

        return JSONResponse({"status": "success", "forwarded": True})
    except Exception as e:
        print("Ошибка:", e)
        return JSONResponse(
            status_code=500,
            content={"error": "Internal server error"}
        )

@app.get("/webhook")
async def handle_webhook_get(request: Request):
    try:
        return JSONResponse(
            status_code=200,
            content={"result": "get query"}
        )
    except Exception as e:
        print("Ошибка:", e)
        return JSONResponse(
            status_code=500,
            content={"error": "Internal server error"}
        )


# Для тестового эндпоинта (не используется в продакшене)
@app.get("/")
def read_root():
    return {"status": "webhook is running. version: 1.01"}
