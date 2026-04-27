FROM maven:3.9.6-eclipse-temurin-11 AS build_image

COPY . /vprofile-project
WORKDIR /vprofile-project

RUN mvn clean package -DskipTests

FROM tomcat:9-jre11

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build_image /vprofile-project/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
