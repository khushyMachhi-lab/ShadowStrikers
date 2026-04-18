#!/bin/bash
# =============================================================
# ShadowStrikers - Quick Deploy Script
# Run this on your server to deploy the application.
#
# Usage: chmod +x production/deploy.sh && ./production/deploy.sh
# =============================================================

set -e

echo "=========================================="
echo " ShadowStrikers - Deployment Script"
echo "=========================================="

# Check Docker is installed
if ! command -v docker &> /dev/null; then
    echo "ERROR: Docker is not installed."
    echo "Install it first: curl -fsSL https://get.docker.com | sh"
    exit 1
fi

# Check Docker Compose is available
if ! docker compose version &> /dev/null; then
    echo "ERROR: Docker Compose is not available."
    exit 1
fi

# Check for .env file
if [ ! -f .env ]; then
    echo "No .env file found. Creating from .env.example..."
    cp .env.example .env
    echo ""
    echo "IMPORTANT: Edit .env with your values before continuing!"
    echo "  nano .env"
    echo ""
    echo "Required changes:"
    echo "  - MYSQL_PASSWORD (strong database password)"
    echo "  - MYSQL_ROOT_PASSWORD (strong root password)"
    echo "  - ADMIN_PASSWORD (strong admin login password)"
    echo ""
    read -p "Have you updated .env? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Please edit .env first, then run this script again."
        exit 1
    fi
fi

# Build and start
echo ""
echo "Building and starting containers..."
docker compose up -d --build

echo ""
echo "Waiting for MySQL to be ready..."
sleep 15

# Check if MySQL is healthy
MAX_RETRIES=30
RETRY=0
until docker compose exec mysql mysqladmin ping -h localhost --silent 2>/dev/null || [ $RETRY -eq $MAX_RETRIES ]; do
    RETRY=$((RETRY+1))
    echo "  Waiting for MySQL... ($RETRY/$MAX_RETRIES)"
    sleep 2
done

if [ $RETRY -eq $MAX_RETRIES ]; then
    echo "ERROR: MySQL did not become ready in time."
    echo "Check logs: docker compose logs mysql"
    exit 1
fi

echo ""
echo "Restarting app to ensure database connection..."
docker compose restart app

echo ""
echo "=========================================="
echo " Deployment Complete!"
echo "=========================================="
echo ""
echo " Application URL: http://$(hostname -I | awk '{print $1}'):8080/home"
echo ""
echo " Useful commands:"
echo "   View logs:     docker compose logs -f app"
echo "   Stop:          docker compose down"
echo "   Rebuild:       docker compose up -d --build"
echo "   MySQL shell:   docker compose exec mysql mysql -u shadowstriker -p shadowstrikers"
echo ""