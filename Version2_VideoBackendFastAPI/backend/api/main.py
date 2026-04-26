from fastapi import FastAPI
import asyncio
import httpx
from datetime import datetime
import aiomysql

app = FastAPI()

URL = "http://198.168.1.202/data"

DB_CONFIG = {
    "host": "mariadb",
    "port": 3306,
    "user": "root",
    "password": "123456",
    "db": "dht"
}

async def fetch_data_loop():
    async with httpx.AsyncClient() as client:
        while True:
            try:
                response = await client.get(URL, timeout=5.0)
                response.raise_for_status()
                data = response.json()

                data_values = {
                    "temperature": data.get("temperature"),
                    "humidity": data.get("humidity"),
                    "timestamp": data.get("timestamp")
                    }
                print(data_values, flush=True)
                try:
                    await save_to_db(data_values)
                except Exception as e:
                    print(f"Error saving fallback data to DB: {e}", flush=True)

            except (httpx.RequestError, httpx.HTTPStatusError, asyncio.TimeoutError):
                
                print("Error fetching data from API", flush=True)

                

            await asyncio.sleep(10)


@app.on_event("startup")
async def startup_event():
    asyncio.create_task(fetch_data_loop())

@app.get("/data")
async def get_last_50():
    async with aiomysql.connect(**DB_CONFIG) as conn:
        async with conn.cursor(aiomysql.DictCursor) as cursor:
            await cursor.execute("SELECT * FROM sensor_data ORDER BY date DESC LIMIT 50")
            results = await cursor.fetchall()
    return results

async def save_to_db(data):
    async with aiomysql.connect(**DB_CONFIG) as conn:
        async with conn.cursor() as cursor:
            await cursor.execute(
                "INSERT INTO sensor_data (temperature, humidity, date) VALUES (%s, %s, %s)",
                (data.get("temperature"), data.get("humidity"), data.get("timestamp"))
            )
            await conn.commit()