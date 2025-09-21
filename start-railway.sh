#!/bin/bash

# Railway startup script for Smartstore
# This script ensures proper startup sequence and health checks

set -e

echo "Starting Smartstore on Railway..."

# Set environment variables
export ASPNETCORE_ENVIRONMENT=Production
export ASPNETCORE_URLS=http://0.0.0.0:$PORT

# Optimize .NET runtime for faster startup
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
export DOTNET_EnableDiagnostics=0
export DOTNET_UseSharedCompilation=false

# Start the application immediately
echo "Starting Smartstore.Web application..."
exec ./Smartstore.Web --urls http://0.0.0.0:$PORT
