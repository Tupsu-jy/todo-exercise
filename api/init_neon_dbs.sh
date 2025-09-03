#!/bin/bash

# Ask for user confirmation before proceeding
echo "This script will initialize both development and production databases."
echo "WARNING: This will DROP ALL DATA in both databases!"
echo ""
read -p "Are you sure you want to continue? (y/N): " confirmation

if [[ ! "$confirmation" =~ ^[Yy]$ ]]; then
    echo "Operation cancelled."
    exit 1
fi

echo "Proceeding with database initialization..."
echo ""


#doing fresh init for dev db
php artisan migrate:fresh
php artisan db:seed

#doing fresh init for prod db
source .env
export DB_URL=$DB_URL_PROD
echo $DB_URL_PROD
echo $DB_URL
php artisan migrate:fresh
php artisan db:seed
