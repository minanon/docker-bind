#!/bin/bash

# for load gssapi-keytab
smb_base=/var/lib/samba/private
key_file=${smb_base}/dns.keytab
dns_dir=${smb_base}/dns
sam_dir=${smb_base}/sam.ldb.d

chgrp bind -R ${key_file} ${dns_dir} ${sam_dir}
chmod g+r -R ${key_file} ${dns_dir} ${sam_dir}

chown -R bind. /etc/bind /etc/bind.org

# start
exec /start.sh
