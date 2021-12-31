## Stage 1
FROM maven:3.6.3-openjdk-8-slim AS builder

MAINTAINER pranav.dhope@gmail.com

WORKDIR /app
COPY . .

RUN mvn install

## Stage 2
FROM openjdk:8-jdk-slim

COPY --from=builder /app/target/springboot-helloworld.jar springboot-helloworld.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","springboot-helloworld.jar"]
