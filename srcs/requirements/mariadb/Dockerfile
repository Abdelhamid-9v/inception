FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

# Create necessary directories and set permissions
RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

COPY conf/zz-mariadb.cnf /etc/mysql/mariadb.conf.d/zz-mariadb.cnf

# Copy the startup script
COPY tools/mariadb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb.sh


ENTRYPOINT ["/usr/local/bin/mariadb.sh"]