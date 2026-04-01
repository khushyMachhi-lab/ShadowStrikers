# Use Java 21 JDK for building and running
FROM eclipse-temurin:21-jdk-jammy

# Set working directory
WORKDIR /app

# Copy full project files
COPY . .

# Give permission to Maven wrapper
RUN chmod +x mvnw

# Build jar inside container (This creates the target folder and jar)
RUN ./mvnw clean package -DskipTests

# EXPOSE port 8080 (Render's default)
EXPOSE 8080

# --- IMPORTANT: Pass Render Environment Variables to Spring Boot ---
# Aa lines Render na Dashboard mathi values lai ne Spring Boot ne apshe
ENV DB_URL=${DB_URL}
ENV DB_USERNAME=${DB_USERNAME}
ENV DB_PASSWORD=${DB_PASSWORD}
ENV PORT=8080

# Run the application with dynamic port and database settings
ENTRYPOINT ["java", "-Dserver.port=${PORT}", "-jar", "target/student-registrtion-0.0.1-SNAPSHOT.jar"]