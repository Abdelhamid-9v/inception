FROM debian:bullseye

# Install Redis
RUN apt-get update && apt-get install -y redis-server && \
    rm -rf /var/lib/apt/lists/*

# Copy the config script (if you want one) or modify directly
# We will modify the config in the CMD or COPY a custom one.
# For simplicity, let's copy a custom config.
COPY conf/redis.conf /etc/redis/redis.conf

EXPOSE 6379

# Start Redis with our config
# --protected-mode no: Allows external connections (from WordPress)
CMD ["redis-server", "/etc/redis/redis.conf"]