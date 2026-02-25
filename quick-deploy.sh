#!/bin/bash

# Quick Deploy Script for OAuth2 Proxy with Azure
# This script provides a simple deployment workflow

set -e

echo "=== OAuth2 Proxy Quick Deploy Script ==="
echo ""

# Check if requirements.txt exists
if [ -f "requirements.txt" ]; then
    echo "Installing Python dependencies..."
    # Use pip3 explicitly to ensure Python 3 is used
    if command -v pip3 &> /dev/null; then
        pip3 install -r requirements.txt
    elif command -v pip &> /dev/null; then
        # Check if pip is Python 3
        PYTHON_VERSION=$(pip --version | grep -oP 'python \d+\.\d+' | grep -oP '\d+')
        if [ "$PYTHON_VERSION" -ge 3 ]; then
            pip install -r requirements.txt
        else
            echo "Error: Python 3 is required but pip is pointing to Python 2"
            exit 1
        fi
    else
        echo "Error: pip3 or pip not found. Please install Python 3 and pip."
        exit 1
    fi
    echo "Dependencies installed successfully."
    echo ""
else
    echo "Warning: requirements.txt not found. Skipping Python dependencies installation."
    echo ""
fi

# Verify Python package versions if installed
echo "Verifying installed package versions..."
if command -v pip3 &> /dev/null; then
    pip3 list | grep -E "lightgbm|python-multipart|snowflake" || echo "Python packages not found."
elif command -v pip &> /dev/null; then
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
