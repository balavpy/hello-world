FROM tomcat:latest
WORKDIR /app
COPY ./webapp.war /tmp/
