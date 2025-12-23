FROM debian:bullseye

RUN apt-get update && apt-get install -y vsftpd && \
    rm -rf /var/lib/apt/lists/*

COPY conf/vsftpd.conf /etc/vsftpd.conf
RUN sed -i 's/\r$//' /etc/vsftpd.conf

COPY tools/run_ftp.sh /tmp/run_ftp.sh

RUN chmod +x /tmp/run_ftp.sh

RUN mkdir -p /var/run/vsftpd/empty

ENTRYPOINT ["/tmp/run_ftp.sh"]