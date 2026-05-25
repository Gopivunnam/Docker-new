FROM tomcat:10.1-jre17-alpine
WORKDIR /usr/local/tomcat/webapps/

# Clear default apps
RUN rm -rf ROOT docs examples manager host-manager

# Create a clean ROOT folder and copy static files into it
RUN mkdir ROOT
COPY ./public/ ./ROOT/

EXPOSE 8080
CMD ["catalina.sh", "run"]