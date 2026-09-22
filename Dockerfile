FROM eclipse-temurin:11-jre

WORKDIR /app

COPY target/videoclub-1.0-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
