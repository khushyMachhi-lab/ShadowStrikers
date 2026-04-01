FROM eclipse-temurin:21-jdk-jammy

WORKDIR /app

# Copy jar file
COPY target/student-registrtion-0.0.1-SNAPSHOT.jar app.jar

# Expose port
EXPOSE 8088

# Run jar file
ENTRYPOINT ["java", "-jar", "app.jar"]