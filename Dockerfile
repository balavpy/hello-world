# hadolint ignore=DL3013
FROM tomcat
COPY webapp/target/webapp.war /tmp/
