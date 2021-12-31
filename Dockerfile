FROM openjdk:8-jdk-slim

COPY target/springboot-helloworld.jar springboot-helloworld.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","springboot-helloworld.jar"]