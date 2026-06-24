#!/bin/bash

echo "=============================================="
echo "      SENTRIX MINI-SOC ENV VALIDATOR"
echo "=============================================="
echo ""

# Docker Installation Check
if command -v docker >/dev/null 2>&1; then
    echo "[✓] Docker is installed"
else
    echo "[✗] Docker is NOT installed"
fi

# Docker Engine Check
if docker info >/dev/null 2>&1; then
    echo "[✓] Docker Engine is running"
else
    echo "[✗] Docker Engine is NOT running"
fi

# Docker Compose Check
if docker compose version >/dev/null 2>&1; then
    echo "[✓] Docker Compose is available"
else
    echo "[✗] Docker Compose is NOT available"
fi

echo ""

# Compose File Check
if [ -f "docker-compose.yml" ]; then
    echo "[✓] docker-compose.yml found"
else
    echo "[✗] docker-compose.yml not found"
fi

echo ""

# Required Images Check
echo "[+] Checking cached container images..."

IMAGES=(
    "alpine"
    "nginx"
    "keycloak"
    "modsecurity"
)

for img in "${IMAGES[@]}"
do
    if docker images | grep -iq "$img"; then
        echo "[✓] $img image available"
    else
        echo "[!] $img image not found"
    fi
done

echo ""

# Docker Storage Summary
echo "[+] Docker Storage Summary"

if docker system df >/dev/null 2>&1; then
    docker system df
else
    echo "[!] Unable to retrieve Docker storage statistics"
fi

echo ""
echo "[+] Environment validation complete."