import os
from fastapi import FastAPI
from databases import Database
from sqlalchemy import create_engine, MetaData, Table, Column, Integer, String

app = FastAPI()

# Get the database configuration from environmental variables.
# Note - they will be provided by docker-compose (.env).
db_user = os.getenv("MARIADB_USER")
db_password = os.getenv("MARIADB_PASSWORD")
db_name = os.getenv("MARIADB_DATABASE")
db_host = os.getenv("MARIADB_HOST")

# Configure the database connection
database = Database(f"mariadb://{db_user}:{db_password}@{db_host}/{db_name}")

# SQLAlchemy metadata
metadata = MetaData()

# Define the table schema
users = Table(
    "users",
    metadata,
    Column("id", Integer, primary_key=True),
    Column("name", String(50)),
    Column("email", String(50)),
)

@app.on_event("startup")
async def startup():
    # Connect to the database
    await database.connect()

    # Create the users table if it doesn't exist
    engine = create_engine(str(database.url))
    metadata.create_all(engine)

@app.on_event("shutdown")
async def shutdown():
    # Disconnect from the database
    await database.disconnect()

@app.get("/users/{user_id}")
async def get_user(user_id: int):
    query = users.select().where(users.c.id == user_id)
    result = await database.fetch_one(query)
    return result

@app.post("/users")
async def create_user(name: str, email: str):
    query = users.insert().values(name=name, email=email)
    last_record_id = await database.execute(query)
    return {"id": last_record_id}