---
name: Production environment design for ShadowStrikers
description: Docker Compose and Dockerfile design for Spring Boot + MySQL stack
type: project
---

# Production environment design (2026-04-07)

## 1. Architecture Overview
- **MySQL service** (`mysql:8.0`) with a named volume `mysql-data` for persistence.
- **Spring Boot service** built from a multi‑stage Dockerfile, runs on `openjdk:21-jdk-slim`.
- Services communicate over Docker default bridge network; the app connects to MySQL via the service name `mysql`.
- Spring Boot internal port **8080** is mapped to host **8082**.
- `depends_on` with a healthcheck guarantees the app starts only after MySQL is healthy.

## 2. Dockerfile (app)
```dockerfile
# ---- Build stage ----
FROM maven:3.9-eclipse-temurin-21 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -B -DskipTests package

# ---- Runtime stage ----
FROM eclipse-temurin:21-jdk-alpine
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
```
- Multi‑stage reduces final image size.
- No extra tools are installed in the runtime image.

## 3. docker‑compose.yml
```yaml
version: "3.9"

services:
  mysql:
    image: mysql:8.0
    container_name: mysql
    environment:
      MYSQL_ROOT_PASSWORD: rootpwd
      MYSQL_DATABASE: studentdb
      MYSQL_USER: student
      MYSQL_PASSWORD: studentpwd
    volumes:
      - mysql-data:/var/lib/mysql
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "--silent"]
      interval: 5s
      timeout: 3s
      retries: 5

  app:
    build: .
    container_name: student-app
    depends_on:
      mysql:
        condition: service_healthy
    environment:
      SPRING_DATASOURCE_URL: jdbc:mysql://mysql:3306/studentdb?useSSL=false&allowPublicKeyRetrieval=true
      SPRING_DATASOURCE_USERNAME: student
      SPRING_DATASOURCE_PASSWORD: studentpwd
    ports:
      - "8082:8080"

volumes:
  mysql-data:
```
- Credentials are kept in plain text for this school demo.
- Spring Boot will automatically create the schema on first run via JPA/Hibernate.

## 4. Environment variables & secrets
- `MYSQL_ROOT_PASSWORD`, `MYSQL_DATABASE`, `MYSQL_USER`, `MYSQL_PASSWORD` are defined in the compose file.
- `SPRING_DATASOURCE_*` variables let the Spring app locate the DB.
- In production you would move these to a `.env` file or Docker secrets.

## 5. Running the stack
```bash
# Build images and start containers
docker compose up --build
```
- The first run downloads images, builds the app, creates the MySQL volume, and starts both services.
- Logs will show JPA creating tables on first launch.

## 6. Persistence & data reset
- Data lives in the Docker volume `mysql-data`. To reset:
```bash
docker compose down
docker volume rm $(docker volume ls -q | grep mysql-data)
```
- The next `docker compose up` will start with a fresh empty database.

## 7. Notes & assumptions
- MySQL version chosen: **8.0** (stable, widely used).
- No initialization scripts; Spring Boot creates schema automatically.
- No reverse proxy; the app is exposed directly on host port 8082 as requested.
- This design is simple enough for a school project yet follows production‑like separation of concerns.

---
*Spec self‑review notes*
- No placeholders or TODOs remain.
- All environment variable names match Spring Boot defaults.
- Port mapping and volume names are consistent.
- The design stays within the requested simplicity.

Please review the file `docs/superpowers/specs/2026-04-07-production-env-design.md`. Let me know if any changes are needed before we move to the implementation plan.