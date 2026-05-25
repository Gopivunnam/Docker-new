FROM nginx:1.25-alpine

LABEL maintainer="gopivunnam721@gmail.com"
LABEL description="Pure Nginx production-ready web server"

# Set system timezone to UTC
ENV TZ=UTC

# Step 2: Set the working directory for your website content
WORKDIR /usr/share/nginx/html

# Step 3: Clear any default placeholder files
RUN rm -rf ./*

# Step 4: Generate a responsive placeholder site directly 
# NOTE: If you have your own local files, comment out this RUN block 
# and use this command instead: COPY ./your-local-html-folder/ .
RUN echo '<!DOCTYPE html>\n\
<html>\n\
<head>\n\
    <meta charset="UTF-8">\n\
    <title>Nginx Production Server</title>\n\
    <style>\n\
        body { font-family: system-ui, sans-serif; background: #0f172a; color: #f8fafc; text-align: center; padding: 80px 20px; }\n\
        .container { background: #1e293b; padding: 40px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.4); display: inline-block; max-width: 500px; }\n\
        h1 { color: #38bdf8; margin-top: 0; }\n\
        p { color: #94a3b8; line-height: 1.6; }\n\
        .status-pill { background: #10b981; color: white; padding: 6px 14px; border-radius: 20px; font-size: 0.85em; font-weight: bold; display: inline-block; }\n\
    </style>\n\
</head>\n\
<body>\n\
    <div class="container">\n\
        <h1>Nginx Server Online</h1>\n\
        <p>Your pure Nginx container is built and running beautifully.</p>\n\
        <div class="status-pill">Status: Active</div>\n\
    </div>\n\
</body>\n\
</html>' > index.html

# Step 5: Expose Nginx standard HTTP web traffic port
EXPOSE 80

# Step 6: Health check to monitor engine uptime automatically
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

# Step 7: Launch Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]