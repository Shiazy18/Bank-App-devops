FROM maven:3.8.3-openjdk-17 AS builder 

LABEL app="bankapp"

WORKDIR /src

COPY . /src/

RUN mvn clean install -DskipTests=true

#FROM amazoncorretto:17-alpine AS deployer

FROM amazoncorretto:25-alpine3.21 AS deployer

COPY --from=builder /src/target/*.jar /src/target/bankapp.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/src/target/bankapp.jar"]