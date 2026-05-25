# =========================================================================
# 1. BASE IMAGE & ENVIRONMENT SETUP
# =========================================================================
FROM tomcat:10.1-jdk17-temurin-jammy

LABEL maintainer="admin@example.com"
LABEL description="Total turnkey Apache Tomcat web server environment"

# Set non-interactive installation mode for system updates
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /usr/local/tomcat

# =========================================================================
# 2. OS SECURITY UPDATES & UTILITIES
# =========================================================================
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends curl tzdata && \
    rm -rf /var/lib/apt/lists/*

# Set timezone to UTC
ENV TZ=UTC

# =========================================================================
# 3. TOMCAT HARDENING & CLEANUP
# =========================================================================
# Remove default, vulnerable manager/example applications
RUN rm -rf webapps/* webapps.dist

# Create a clean root directory for your website
RUN mkdir -p webapps/ROOT

# =========================================================================
# 4. WEBSITE CONTENT GENERATION / DEPLOYMENT
# =========================================================================
# This writes a live, styled placeholder index page directly into Tomcat.
# If you have local files, swap this block for: COPY ./my-web-files/ webapps/ROOT/
RUN echo '<!DOCTYPE html>\n\
<html>\n\
<head>\n\
    <title>Tomcat Server Live</title>\n\
    <style>\n\
        body { font-family: sans-serif; background: #f4f6f9; text-align: center; padding: 50px; }\n\
        .card { background: white; padding: 40px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); display: inline-block; }\n\
        h1 { color: #F25F5C; }\n\
    </style>\n\
</head>\n\
<body>\n\
    <div class="card">\n\
        <h1>Apache Tomcat Web Server</h1>\n\
        <p>Your total Dockerfile deployment is running successfully!</p>\n\
    </div>\n\
</body>\n\
</html>' > webapps/ROOT/index.html

# =========================================================================
# 5. CONTAINER PERFORMANCE & MONITORING
# =========================================================================
# Configure Tomcat's memory footprint
ENV CATALINA_OPTS="-Xms512M -Xmx1024M -server -XX:+UseG1GC"

# Network web port
EXPOSE 8080

# Health check script to monitor container status automatically
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

# =========================================================================
# 6. SERVER EXECUTION
# =========================================================================
CMD ["catalina.sh", "run"]