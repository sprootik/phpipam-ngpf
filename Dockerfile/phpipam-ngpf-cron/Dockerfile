FROM phpipam-ngpf:v1.5.0

ARG VERSION="v1.5.0"
ENV SCAN_INTERVAL=""

LABEL name="phpIPAM cron container" \
      version=$VERSION \
      maintainer="sprootik <sprootik89@gmail.com>"

COPY start_crond.sh /
RUN chmod +x /start_crond.sh

CMD ["/start_crond.sh"]
