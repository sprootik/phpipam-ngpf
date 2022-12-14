#!/bin/sh

if [ -n "$TZ" ]; then
  setup-timezone -z $TZ
  echo -e "[Date]\ndate.timezone = $TZ" >/etc/php7/conf.d/99_tz.ini
fi

if [ $? -ne 0 ]
then
  exit 1
fi

set -f
case "$SCAN_INTERVAL" in
  5m)  CRON_S="*/5 *"
  ;;
  10m) CRON_S="*/10 *"
  ;;
  15m) CRON_S="*/15 *"
  ;;
  30m) CRON_S="*/30 *"
  ;;
  1h)  CRON_S="0 *"
  ;;
  2h)  CRON_S="0 */2"
  ;;
  4h)  CRON_S="0 */4"
  ;;
  6h)  CRON_S="0 */6"
  ;;
  12h) CRON_S="0 */12"
  ;;
  *)   CRON_S="0 *"
  ;;
esac

echo "$CRON_S *  *  * /usr/bin/php /phpipam/functions/scripts/discoveryCheck.php"      >/etc/crontabs/root
echo "$CRON_S *  *  * /usr/bin/php /phpipam/functions/scripts/pingCheck.php"          >>/etc/crontabs/root
echo "$CRON_S *  *  * /usr/bin/php /phpipam/functions/scripts/resolveIPaddresses.php" >>/etc/crontabs/root

/usr/sbin/crond -f -l 8 -L /dev/stdout
