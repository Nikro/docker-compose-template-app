# Use the official Python base image
FROM python:3.9-slim

# Install the required system dependencies
# Import the MariaDB GPG key
RUN apt-get update && apt-get install -y curl gnupg
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
RUN curl -LsS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash
RUN apt-get update && apt-get install -y libmariadb3 libmariadb-dev
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
