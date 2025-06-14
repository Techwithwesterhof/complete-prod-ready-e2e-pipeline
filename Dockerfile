# -------------------------------
# Stage 1: Build the application
# -------------------------------
FROM maven:3.9.0-eclipse-temurin-17 AS build

# Metadata about the maintainer
LABEL maintainer="oyinkansola.wahab@hotmail.com"

# Set the working directory inside the container for the build process
WORKDIR /app

# Copy the entire project source code into the container
# (Use a .dockerignore file to avoid copying unnecessary files like .git, target/, etc.)
COPY . .

# Build the application using Maven, skipping tests for faster build time
RUN mvn clean package -DskipTests

# -------------------------------
# Stage 2: Create a minimal runtime image
# -------------------------------
FROM eclipse-temurin:17.0.6_10-jdk

# Set the working directory inside the container for the runtime environment
WORKDIR /app

# Copy the built JAR file from the build stage into this final image
COPY --from=build /app/target/*.jar /app/demoapp.jar

# Document the port that the containerized app will listen on
EXPOSE 8080

# Define the command to run the application
CMD ["java", "-jar", "demoapp.jar"]
