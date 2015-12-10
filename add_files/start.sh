#!/bin/bash

[ -z "$(find /etc/bind -type f)" ] && \
    cp /etc/bind.org/* /etc/bind

exec /usr/sbin/named -f -u bind
