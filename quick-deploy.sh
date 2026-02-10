#!/bin/bash

# Quick Deploy Script for OAuth2 Proxy with Azure
# This script provides a simple deployment workflow

set -e

echo "=== OAuth2 Proxy Quick Deploy Script ==="
echo ""

# Check if requirements.txt exists
if [ -f "requirements.txt" ]; then
    echo "Installing Python dependencies..."
    pip install -r requirements.txt
    echo "Dependencies installed successfully."
    echo ""
else
    echo "Warning: requirements.txt not found. Skipping Python dependencies installation."
    echo ""
fi

# Verify Python package versions if installed
echo "Verifying installed package versions..."
if command -v pip &> /dev/null; then
    pip list | grep -E "lightgbm|python-multipart|snowflake" || echo "Python packages not found."
fi
echo ""

# Build the Go application
if [ -f "Makefile" ]; then
    echo "Building oauth2-proxy..."
    make build
    echo "Build completed successfully."
    echo ""
else
    echo "Error: Makefile not found. Cannot build the application."
    exit 1
fi

# Run tests if available
if [ -f "Makefile" ]; then
    echo "Running tests..."
    make test || echo "Warning: Some tests failed. Review output above."
    echo ""
fi

echo "=== Deployment completed ==="
echo ""
echo "To run oauth2-proxy, use:"
echo "  ./oauth2-proxy --config=<your-config-file>"
echo ""
echo "For Azure configuration, see:"
echo "  https://oauth2-proxy.github.io/oauth2-proxy/configuration/providers/azure"
