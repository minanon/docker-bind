#!/bin/bash

# for load gssapi-keytab
key_file=/var/lib/samba/private/dns.keytab

chgrp bind ${key_file}
chmod g+r ${key_file}

chown -R bind. /etc/bind /etc/bind.org

# start
exec /start.sh
