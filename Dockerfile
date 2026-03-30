# Java 21 વાપરો
FROM eclipse-temurin:21-jdk-jammy

# કામ કરવાનું ફોલ્ડર સેટ કરો
WORKDIR /app

# Maven wrapper અને pom.xml કોપી કરો
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline

# આખો કોડ કોપી કરો
COPY src ./src

# એપ્લિકેશન રન કરો
CMD ["./mvnw", "spring-boot:run"]