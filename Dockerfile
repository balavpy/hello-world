# hadolint ignore=DL3007
FROM tomcat:latest
COPY webapp/target/webapp.war /tmp/
