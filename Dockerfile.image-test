# =============================================================
# INTENTIONALLY VULNERABLE DOCKER IMAGE — FOR FCS IMAGE TESTING
# =============================================================
# ⚠️  DO NOT USE IN PRODUCTION — THIS IS FOR TESTING ONLY ⚠️
# =============================================================

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    openssl \
    libssl-dev \
    curl \
    libcurl4-openssl-dev \
    python3 \
    python3-pip \
    git \
    wget \
    openssh-client \
    openssh-server \
    net-tools \
    netcat-openbsd \
    telnet \
    imagemagick \
    vim \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir \
    flask==2.0.0 \
    jinja2==3.0.0 \
    requests==2.25.0 \
    werkzeug==2.0.0 \
    pyyaml==5.3 \
    cryptography==3.4.0 \
    pillow==8.0.0 \
    urllib3==1.26.0 \
    setuptools==50.0.0

ENV DATABASE_URL="postgresql://admin:P@ssw0rd123@db.internal:5432/production"
ENV AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"
ENV AWS_SECRET_ACCESS_KEY="wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"

EXPOSE 22 80 443 3306 5432 8080

RUN echo '#!/bin/bash\necho "Vulnerable test container running"\ntail -f /dev/null' > /start.sh \
    && chmod +x /start.sh

CMD ["/start.sh"]
