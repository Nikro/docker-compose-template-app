from fastapi import FastAPI

# Create an instance of the FastAPI application
app = FastAPI()

# Define a route and its corresponding function
@app.get("/")
def read_root():
    return {"Hello": "World"}
