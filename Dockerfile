FROM debian:stable

MAINTAINER minanon

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y curl samba gcc make ca-certificates dnsutils libc6-dev libssl-dev libkrb5-dev libcap-dev --no-install-recommends \
    && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# install bind
RUN curl -L 'https://www.isc.org/downloads/file/bind-9-10-3/?version=tar-gz' | tar -zx -C /tmp \
    && cd /tmp/bind-9.10.3/ \
    && ./configure '--prefix=/usr' '--mandir=/usr/share/man' '--infodir=/usr/share/info' '--sysconfdir=/etc/bind' '--localstatedir=/var' '--enable-threads' '--enable-largefile' '--with-libtool' '--enable-shared' '--enable-static' '--with-openssl=/usr' '--with-gnu-ld' '--with-atf=no' '--enable-ipv6' '--enable-filter-aaaa' '--with-dlopen' 'CFLAGS=-fno-strict-aliasing -fno-delete-null-pointer-checks -DDIG_SIGCHASE -O2' \
    && make && make install \
    && cd / && rm -rf /tmp/bind-9.10.3

RUN useradd bind

ADD add_files/bind /etc/bind
RUN cp -r /etc/bind /etc/bind.org

EXPOSE 53/udp 53/tcp
VOLUME [ "/etc/bind" ]
ADD add_files/start.sh /start.sh
ADD add_files/setup.sh /setup.sh
RUN chmod 755 /start.sh /setup.sh

ENTRYPOINT [ "/setup.sh" ]
