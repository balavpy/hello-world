# hadolint ignore=DL3013
FROM tomcat:latest
COPY webapp/target/webapp.war /tmp/
