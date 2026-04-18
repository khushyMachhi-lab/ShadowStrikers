# ---- Stage 1: Build ----
FROM maven:3.9-eclipse-temurin-21 AS builder

WORKDIR /app

# Copy pom.xml first (for dependency caching)
COPY pom.xml .

# Download dependencies (cached layer unless pom.xml changes)
RUN mvn dependency:go-offline -B

# Copy source code and build
COPY src src
RUN mvn clean package -DskipTests -B

# ---- Stage 2: Run ----
FROM eclipse-temurin:21-jre-jammy

WORKDIR /app

# Create upload directories
RUN mkdir -p /app/uploads/user-photos /app/uploads/payment-screenshots /app/uploads/documents /app/uploads/logo

# Copy the WAR from builder stage
COPY --from=builder /app/target/*.war app.war

# Create a non-root user for security
RUN groupadd -r appuser && useradd -r -g appuser appuser && chown -R appuser:appuser /app
USER appuser

EXPOSE 8081

ENTRYPOINT ["java", "-jar", "app.war"]