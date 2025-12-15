FROM debian:bullseye

# 1. Install Python 3
RUN apt-get update && apt-get install -y \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# 2. Set directory
WORKDIR /var/www/html

# 3. Copy the Python script
COPY tools/server.py .

# 4. Run the script
# We use "-u" to force "unbuffered" output (so logs show up instantly)
CMD ["python3", "-u", "server.py"]