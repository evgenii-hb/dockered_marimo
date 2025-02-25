# Dockered Marimo

To install and run Marimo in a Docker container, follow these steps:

```zsh
# Install `uv` if not yet installed
curl -LsSf https://astral.sh/uv/install.sh | sh

# Update pyproject.toml with new dependencies (if needed)
uv add <package_name>

# Regenerate requirements.txt (if dependencies were updated)
uv pip compile pyproject.toml -o requirements.txt

# Build Docker image
docker build -t marimo:local .

# Run marimo in Docker locally
docker run -v .:/marimo/workdir --rm -p 8055:8055 marimo:local
```
