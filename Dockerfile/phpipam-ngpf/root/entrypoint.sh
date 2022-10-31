#!/bin/sh

if [ -n "$TZ" ]; then
  setup-timezone -z $TZ
  echo -e "[Date]\ndate.timezone = $TZ" >/etc/php7/conf.d/99_tz.ini
fi

# RUN
sed -i 's/date.timezone/date.timezone = $TZ/g' /etc/php7/php.ini 
if [ -z "$mode" ]; then
	echo run nginx with php-fpm
	/usr/bin/envsubst < /etc/nginx/http.d/default.conf.template > /etc/nginx/http.d/default.conf
	exec /usr/bin/supervisord -n -c /etc/supervisord.conf
elif [ "$mode" == "nginx" ]; then
	echo run nginx
	/usr/bin/envsubst < /etc/nginx/http.d/default.conf.template > /etc/nginx/http.d/default.conf
	exec /usr/sbin/nginx -g "daemon off;"
elif [ "$mode" == "php-fpm" ]; then
	echo run php-fpm
	exec /usr/sbin/php-fpm7 --force-stderr --nodaemonize
fi
