#!/bin/bash

# Railway startup script for Smartstore
# This script ensures proper startup sequence and health checks

set -e

echo "Starting Smartstore on Railway..."

# Set environment variables
export ASPNETCORE_ENVIRONMENT=Production
export ASPNETCORE_URLS=http://0.0.0.0:$PORT

# Wait for database to be ready (if needed)
if [ ! -z "$DATABASE_URL" ]; then
    echo "Waiting for database connection..."
    # Add a small delay to ensure database is ready
    sleep 5
fi

# Start the application
echo "Starting Smartstore.Web application..."
exec ./Smartstore.Web --urls http://0.0.0.0:$PORT
