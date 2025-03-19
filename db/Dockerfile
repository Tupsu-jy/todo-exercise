# Use the official PostgreSQL image from the Docker Hub
FROM postgres:latest

# Copy the initialization SQL script to the Docker image
COPY db/init.sql /docker-entrypoint-initdb.d/

# Expose the default PostgreSQL port
EXPOSE 5432