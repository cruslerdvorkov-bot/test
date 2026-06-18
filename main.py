from fastapi import FastAPI, Request, HTTPException
import httpx
from fastapi.responses import JSONResponse
import os
import logging

# Настройка логирования
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI()

# Основной вебхук Telegram
@app.post("/webhook")
async def webhook(request: Request):
    try:
        # Получаем данные от Telegram
        data = await request.json()
        logger.info(f"Новое сообщение от Telegram: {data}")  # Логируем запрос

        # Проверяем обязательные поля (минимальная валидация)
        if not data.get("message"):
            logger.warning("Получен пустой запрос от Telegram")
            return JSONResponse(
                status_code=400,
                content={"error": "Invalid request: 'message' field is missing"}
            )

        # Пересылаем данные на ваш сервер
        async with httpx.AsyncClient(timeout=10.0) as client:
            try:
                response = await client.post(
                    os.getenv("TARGET_WEBHOOK_URL", "https://ch46404.tw1.ru/tg/v1/webhook"),
                    json=data,
                    headers={"Content-Type": "application/json"}
                )
                response.raise_for_status()  # Проверяем статус ответа (2xx)
                logger.info("Успешно переслано на целевой сервер")
            except httpx.HTTPStatusError as e:
                logger.error(f"Ошибка целевого сервера: {e.response.status_code} - {e.response.text}")
                raise HTTPException(status_code=502, detail="Target server error")
            except Exception as e:
                logger.error(f"Ошибка при пересылке: {str(e)}")
                raise HTTPException(status_code=500, detail="Failed to forward request")

        return JSONResponse({"status": "forwarded"})

    except Exception as e:
    logger.error(f"Ошибка обработки вебхука: {str(e)}", exc_info=True)
    return JSONResponse(
        status_code=500,
        content={"error": f"Internal server error: {str(e)}"}
    )

# Эндпоинт для проверки статуса
@app.get("/health")
def health():
    return {"status": "running", "version": "1.02"}
