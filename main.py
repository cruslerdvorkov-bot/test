from fastapi import FastAPI, Request
import httpx

app = FastAPI()

# Ваш основной обработчик вебхуков Telegram
@app.post("/webhook")
async def webhook(request: Request):
    data = await request.json()
    print("Новое сообщение:", data)  # Логи для отладки

    # Отправка данных на ваш основной сервер (если нужно)
    async with httpx.AsyncClient() as client:
        await client.post(
            "https://ch46404.tw1.ru/tg/v1/webhook",
            json=data
        )

    return {"status": "ok"}

# Для проверки работоспособности
@app.get("/")
def health():
    return {"status": "running"}
