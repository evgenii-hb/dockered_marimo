# syntax=docker/dockerfile:1.2

# Base image
FROM python:3.10-slim

# Metadata
LABEL version="latest"

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
apt-get update && \
apt-get install -y nodejs

# Verify Node.js installation
RUN node -v

# Add `marimo` to PATH
ENV PATH=/marimo/.venv/bin:$PATH

# Install `uv`
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

# Install marimo notebook environment
WORKDIR /marimo
RUN --mount=type=cache,target=/root/.cache/uv \
    uv venv --no-project .venv
COPY requirements.txt .
RUN --mount=type=cache,target=/root/.cache/uv \
    uv pip install -r requirements.txt

WORKDIR /marimo/workdir
COPY .marimo.toml .

EXPOSE 8055
CMD ["marimo", "edit", "--host", "0.0.0.0", "--port", "8055", "--headless", "--no-token"]
