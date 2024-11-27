#!/bin/bash

# Define the container name and database credentials
CONTAINER_NAME=$(docker-compose ps -q postgres)
DB_NAME="stock_data"
DB_USER="cosc"

# Define the backup file name
BACKUP_FILE="backup.sql"

# Run the pg_dump command inside the PostgreSQL container
docker exec -t $CONTAINER_NAME pg_dump -U $DB_USER $DB_NAME > $BACKUP_FILE

echo "Backup completed: $BACKUP_FILE"