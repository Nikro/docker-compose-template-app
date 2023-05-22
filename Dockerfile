# Use the official Python base image
FROM python:3.9-slim

# Install the required system dependencies
RUN apt-get update && apt-get install -y gnupg2
RUN apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
RUN echo "deb [arch=amd64,arm64,ppc64el] http://mariadb.mirror.globo.tech/repo/10.6/debian buster main" > /etc/apt/sources.list.d/mariadb.list
# Install MariaDB client
RUN apt-get update && apt-get install -y mariadb-client

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
