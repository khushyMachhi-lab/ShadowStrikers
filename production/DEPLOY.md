# ShadowStrikers - Deployment Guide

## Prerequisites

- A server (VPS) running **Linux** (Ubuntu 22.04+ recommended)
- **Docker** and **Docker Compose** installed on the server
- **Git** installed on the server
- A domain name pointing to your server's IP (optional, for HTTPS)

---

## Step 1: Install Docker on Your Server

```bash
# Update packages
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com | sh

# Install Docker Compose plugin (comes with Docker on most systems)
# Verify installation
docker --version
docker compose version

# Add your user to the docker group (so you don't need sudo every time)
sudo usermod -aG docker $USER
# Log out and back in for this to take effect
```

---

## Step 2: Get the Code on Your Server

```bash
# Option A: Clone from Git
git clone <your-repo-url> /opt/shadowstrikers
cd /opt/shadowstrikers

# Option B: Copy via SCP from your local machine
# On your local machine:
scp -r ./ShadowStrikers-main user@your-server-ip:/opt/shadowstrikers
```

---

## Step 3: Configure Environment Variables

```bash
cd /opt/shadowstrikers

# Copy the example env file
cp .env.example .env

# Edit .env with your values
nano .env
```

**Required changes in `.env`:**
- `MYSQL_PASSWORD` - Set a strong database password
- `MYSQL_ROOT_PASSWORD` - Set a strong root password
- `ADMIN_PASSWORD` - Set a strong admin login password

**Optional changes:**
- `SPRING_MAIL_*` - Configure for email (registration, OTP password reset)
- `GOOGLE_CLIENT_ID/SECRET/TOKEN` - Configure for Google Calendar Meet links

---

## Step 4: Deploy

```bash
cd /opt/shadowstrikers

# Build and start everything (MySQL + App)
docker compose up -d --build
```

This will:
1. Build the Java application using Maven inside Docker
2. Start MySQL database
3. Wait for MySQL to be healthy
4. Start the application on port 8080

---

## Step 5: Verify It's Running

```bash
# Check containers are running
docker compose ps

# Check application logs
docker compose logs app

# Check MySQL logs
docker compose logs mysql

# Test the application
curl http://localhost:8080/home
```

Open your browser and go to: `http://your-server-ip:8080/home`

---

## Common Operations

### View Logs
```bash
# Follow app logs in real-time
docker compose logs -f app

# Follow MySQL logs
docker compose logs -f mysql

# See last 100 lines
docker compose logs --tail 100 app
```

### Restart the App
```bash
docker compose restart app
```

### Rebuild After Code Changes
```bash
docker compose up -d --build app
```

### Stop Everything
```bash
docker compose down
```

### Stop and Remove Data (Fresh Start)
```bash
# WARNING: This deletes the database and uploaded files!
docker compose down -v
```

### Access MySQL Directly
```bash
docker compose exec mysql mysql -u shadowstriker -p shadowstrikers
# Or as root:
docker compose exec mysql mysql -u root -p
```

---

## File Uploads

Uploaded files (user photos, payment screenshots, documents) are stored in a Docker volume named `uploads`. This volume persists across container restarts.

To back up uploaded files:
```bash
# Find the volume mount point
docker volume inspect shadowstrikers_uploads

# Copy files from the volume
docker compose exec app tar czf /tmp/uploads-backup.tar.gz -C /app/uploads .
docker cp shadowstrikers-app-1:/tmp/uploads-backup.tar.gz ./uploads-backup.tar.gz
```

---

## Database Backups

```bash
# Create a backup
docker compose exec mysql mysqldump -u root -p shadowstrikers > backup.sql

# Restore from backup
docker compose exec -T mysql mysql -u root -p shadowstrikers < backup.sql
```

---

## HTTPS Setup (Recommended for Production)

Use Nginx as a reverse proxy with Let's Encrypt:

```bash
# Install Nginx and Certbot
sudo apt install nginx certbot python3-certbot-nginx -y

# Create Nginx config
sudo nano /etc/nginx/sites-available/shadowstrikers
```

Add this configuration:
```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        client_max_body_size 10M;
    }
}
```

```bash
# Enable the site
sudo ln -s /etc/nginx/sites-available/shadowstrikers /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx

# Get SSL certificate
sudo certbot --nginx -d your-domain.com
```

---

## Troubleshooting

### App fails to start
```bash
docker compose logs app
```
Common issues:
- MySQL not ready yet → restart app: `docker compose restart app`
- Missing env vars → check `.env` file exists

### JSP pages show 404
- Make sure the WAR was built correctly: `docker compose exec app ls /app/target/`
- Check the view resolver is pointing to `/WEB-INF/views/`

### Database connection refused
- Check MySQL is healthy: `docker compose ps`
- Check the database URL in `.env` matches

### File uploads not working
- Check the uploads directory exists: `docker compose exec app ls -la /app/uploads/`
- Check permissions: the app runs as `appuser`

---

## Architecture

```
                    Internet
                        |
                    [Nginx] (optional, for HTTPS)
                        |
                    [App:8080]
                   Spring Boot WAR
                  (embedded Tomcat)
                        |
                    [MySQL:3306]
```

All services run in Docker containers managed by Docker Compose.