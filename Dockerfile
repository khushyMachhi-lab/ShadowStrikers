# Step 1: Java 21 vapro
FROM eclipse-temurin:21-jdk-jammy

# Step 2: Working directory set karo
WORKDIR /app

# Step 3: Badhi files copy karo
COPY . .

# Step 4: Maven wrapper ne permission aapo
RUN chmod +x mvnw

# Step 5: Project build karo (Aa jar file banavshe)
RUN ./mvnw clean package -DskipTests

# Step 6: Port expose karo
EXPOSE 8080

# Step 7: Application run karo (Direct jar file name sathe)
ENTRYPOINT ["java", "-jar", "target/student-registrtion-0.0.1-SNAPSHOT.jar"]