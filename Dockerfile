# Use the official Python base image
FROM python:3.9-slim

# Install the required system dependencies
RUN apt-get update && apt-get install -y gcc wget
RUN wget https://dlm.mariadb.com/3208187/MariaDB/mariadb-10.11.3/repo/debian/mariadb-10.11.3-debian-bullseye-arm64-debs.tar.gz -O - | tar -zxf - --strip-components=1 -C /usr

# Set the working directory inside the container
WORKDIR /app

# Copy the entire app directory to the container
COPY . .

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port that the FastAPI application will be running on
EXPOSE 8080

# Start the FastAPI application with uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
