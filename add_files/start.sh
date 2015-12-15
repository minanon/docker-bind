#!/bin/bash

[ -z "$(find /etc/bind -type f)" ] && \
    cp /etc/bind.org/* /etc/bind

mkdir -p /var/cache/bind
chown bind. /var/cache/bind

exec /usr/sbin/named -f -u bind
