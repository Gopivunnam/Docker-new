FROM tomcat:10.1-alpine

# Remove default Tomcat sample apps for security and a clean setup
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your local website files into Tomcat's root deployment folder
COPY ./my-website/ /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080
CMD ["catalina.sh", "run"]