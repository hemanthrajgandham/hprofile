FROM eclipse-temurin:11 AS build_image

RUN apt-get update && apt-get install -y maven

COPY ./vprofile-project /vprofile-project
WORKDIR /vprofile-project

RUN mvn install

FROM tomcat:9-jre11

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build_image /vprofile-project/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
