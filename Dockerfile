# ===============================
# Stage 1 - Build JAR
# ===============================
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

COPY . .

RUN mvn clean install -DskipTests=true

# ===============================
# Stage 2 - Run Application
# ===============================
# Use stable runtime (openjdk alpine is removed)
FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=builder /app/target/*.jar /app/expenseapp.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/expenseapp.jar"]
