## 👋 Welcome to mastodon 🚀

Decentralized social network platform (fediverse)

## 📋 Description

Decentralized social network platform (fediverse)

## 🚀 Services

- **web**: lscr.io/linuxserver/mastodon:latest - Main Mastodon web application
- **streaming**: ghcr.io/mastodon/mastodon-streaming:latest - Real-time streaming API
- **db**: postgres:14-alpine - PostgreSQL database
- **redis**: redis:7-alpine - Redis cache
- **elastic**: elasticsearch:8.11.0 - Full-text search engine


## 📦 Installation

### Option 1: Quick Install
```bash
curl -q -LSsf "https://raw.githubusercontent.com/composemgr/mastodon/main/docker-compose.yaml" -o compose.yml
```

### Option 2: Git Clone
```bash
git clone "https://github.com/composemgr/mastodon" ~/.local/srv/docker/mastodon
cd ~/.local/srv/docker/mastodon
docker compose up -d
```

### Option 3: Using composemgr
```bash
composemgr install mastodon
```

## 🔧 Configuration

### Environment Variables

#### Basic Configuration

```shell
TZ=America/New_York
BASE_HOST_NAME=$HOSTNAME              # Hostname for Mastodon instance
```

#### Application Secrets

```shell
APP_SECRET_KEY=changeme_otp_secret
APP_JWT_TOKEN=changeme_secret_key_base
ENCRYPTION_KEY=changeme_deterministic_key
VAPID_PRIVATE_KEY=changeme_vapid_private
VAPID_PUBLIC_KEY=changeme_vapid_public
```

#### SMTP Configuration

By default, SMTP authentication is disabled (`SMTP_AUTH_METHOD=none`). Configure the following variables to enable email functionality:

```shell
SMTP_AUTH_METHOD=none                         # Authentication method: none, plain, login, cram_md5
EMAIL_SERVER_HOST=172.17.0.1                  # SMTP server hostname
EMAIL_SERVER_PORT=587                         # SMTP server port (25, 587, 465)
EMAIL_SERVER_LOGIN_NAME=                      # SMTP username (if auth enabled)
EMAIL_SERVER_LOGIN_PASS=                      # SMTP password (if auth enabled)
EMAIL_SERVER_MAIL_FROM=no-reply@example.com   # From address for emails
```

#### Database Configuration

```shell
DB_CREATE_DATABASE_NAME=mastodon
DB_USER_NAME=mastodon
DB_USER_PASS=changeme_db_password
```

#### Elasticsearch Configuration

```shell
ES_PASSWORD=changeme_elastic_password    # Elasticsearch password
```

See `docker-compose.yaml` for complete list of configurable options.

## 🌐 Access

- **Web Interface**: https://172.17.0.1:59038

## 📂 Volumes

- `./rootfs/data/mastodon` - Mastodon application data
- `./rootfs/config/mastodon` - Mastodon configuration
- `./rootfs/data/db/postgres/mastodon` - PostgreSQL database data
- `./rootfs/data/db/redis/mastodon` - Redis cache data
- `./rootfs/data/db/elastic/mastodon` - Elasticsearch indices data

## 🔐 Security

- Change all default passwords before deploying to production
- Use strong secrets for all authentication tokens
- Configure HTTPS using a reverse proxy (nginx, traefik, caddy)
- Regularly update Docker images for security patches
- Backup your data regularly

## 🔍 Logging

```shell
# View all logs
docker compose logs -f

# View specific service logs
docker compose logs -f web
docker compose logs -f streaming
docker compose logs -f db
docker compose logs -f redis
docker compose logs -f elastic
```

## 🛠️ Management

```bash
# Start services
docker compose up -d

# Stop services
docker compose down

# Update to latest images
docker compose pull && docker compose up -d

# View logs
docker compose logs -f

# Restart services
docker compose restart
```

## 📋 Requirements

- Docker Engine 20.10+
- Docker Compose V2+

## 🤝 Author

🤖 casjay: [Github](https://github.com/casjay) 🤖  
🦄 composemgr: [Github](https://github.com/composemgr) 🦄
