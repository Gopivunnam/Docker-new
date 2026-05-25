FROM tomcat:11.0-jre17-temurin

# Remove default Tomcat apps to clean up the environment (Optional)
RUN rm -rf /usr/local/tomcat/webapps/*

# Set the working directory inside the container
WORKDIR /usr/local/tomcat/webapps/

# Create a defaultROOT website directory
RUN mkdir ROOT

# Create a simple HTML landing page inside the website directory
RUN echo "<html><body><h1>Tomcat Docker Site Running Successfully!</h1></body></html>" > ROOT/index.html

# Expose port 8080 to the outside world
EXPOSE 8080