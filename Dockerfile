# --- STAGE 1: Build the Java Application ---
FROM maven:3.9-eclipse-temurin-17-jammy AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the build configuration file first to leverage Docker cache
COPY pom.xml .

# Download dependencies (this layer will be cached unless pom.xml changes)
RUN mvn dependency:go-offline -B

# Copy the rest of your application source code
COPY src ./src

# Package the application into a .war file, skipping unit tests for speed
RUN mvn clean package -DskipTests


# --- STAGE 2: Run the Application in Tomcat ---
FROM tomcat:10.1-jdk17-temurin-jammy

# Remove default Tomcat web applications for security
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built .war file from the builder stage and rename it to ROOT.war
# This ensures your website loads directly at http://localhost/
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Open the standard Tomcat web traffic port
EXPOSE 8080

# Launch Tomcat
CMD ["catalina.sh", "run"]