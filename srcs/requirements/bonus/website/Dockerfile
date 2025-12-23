FROM debian:bullseye
RUN apt-get update && apt-get install -y \
    python3 \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /var/www/html
COPY tools/server.py .
# "-u" to force "unbuffered" output so logs show up instantly
CMD ["python3", "-u", "server.py"]