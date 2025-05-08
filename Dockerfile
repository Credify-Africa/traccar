FROM gradle:7.6.1-jdk17 AS build

WORKDIR /app
COPY . .
RUN ./gradlew assemble

FROM node:18 AS web-build
WORKDIR /app
COPY traccar-web .
RUN npm install && npm run build

FROM openjdk:17-slim

WORKDIR /app

# Copy everything from the build stage
COPY --from=build /app /app

# Copy the built web interface
COPY --from=web-build /app/build /app/traccar-web/build

# Copy configuration
COPY debug.xml /app/debug.xml

# Create necessary directories
RUN mkdir -p /app/media

# Expose the default Traccar ports
EXPOSE 8082 5000-5150

# Set environment variables
ENV JAVA_OPTS="-Xms512m -Xmx2048m"

# Run the application
CMD ["java", "-jar", "tracker-server.jar", "debug.xml"] 