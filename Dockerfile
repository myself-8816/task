FROM tomcat:9-jdk17
COPY target/java-web-app.war /usr/local/tomcat/webapps/
