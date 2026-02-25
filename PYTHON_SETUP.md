# Python Dependencies and Deployment

This directory contains Python-related files that were added to support specific deployment requirements.

## Files

### requirements.txt
Contains Python dependencies with specific versions:
- `lightgbm==4.6.0` - Light Gradient Boosting Machine library
- `python-multipart==0.0.22` - Multipart form data parser
- `snowflake-connector-python==3.13.1` - Snowflake database connector

### tests/test_dependencies.py
A Python test file that verifies:
- Required Python dependencies are available
- OAuth2 Proxy core files exist
- Azure provider is present

### quick-deploy.sh
An executable deployment script that:
1. Installs Python dependencies from requirements.txt
2. Verifies installed package versions
3. Builds the oauth2-proxy Go application
4. Runs tests

## Usage

### Install Dependencies
```bash
pip install -r requirements.txt
```

### Verify Versions
```bash
pip list | grep -E "lightgbm|python-multipart|snowflake"
```

Expected output:
```
lightgbm                    4.6.0
python-multipart            0.0.22
snowflake-connector-python  3.13.1
```

### Run Tests
```bash
pytest tests/
```
or
```bash
python3 tests/test_dependencies.py
```

### Deploy
```bash
./quick-deploy.sh
```

## Azure OAuth Configuration

For Azure OAuth configuration with oauth2-proxy, see:
- [Azure Provider Documentation](https://oauth2-proxy.github.io/oauth2-proxy/configuration/providers/azure)
- Provider implementation: `providers/azure.go`

## Note

These Python dependencies were added per specific requirements but are not part of the core oauth2-proxy functionality, which is a Go-based application. The Azure OAuth provider is already implemented in Go at `providers/azure.go`.
