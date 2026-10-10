# Multi-stage Docker build for TruthLens with AI-Arena
FROM maven:3.9.8-eclipse-temurin-21-alpine AS build
WORKDIR /app

# Cache dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B || true

# Copy source code and ML tools
COPY src ./src
COPY tools ./tools

# Build runnable JAR
RUN mvn clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Copy artifact from build stage
COPY --from=build /app/target/*.jar app.jar
COPY --from=build /app/tools ./tools

# Create data directory for H2 DB
RUN mkdir -p /app/data

EXPOSE 8080
ENV PORT=8080

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar"]
