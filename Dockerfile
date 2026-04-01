# Use Java 21
FROM eclipse-temurin:21-jdk-jammy

# Set working directory
WORKDIR /app

# Copy full project
COPY . .

# Give permission to Maven wrapper
RUN chmod +x mvnw

# Build jar inside container
RUN ./mvnw clean package -DskipTests

# Expose port (Render uses dynamic port, but keep this)
EXPOSE 8089

# Run the application
ENTRYPOINT ["java", "-jar", "target/student-registrtion-0.0.1-SNAPSHOT.jar"]