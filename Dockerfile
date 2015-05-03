FROM crux:latest
MAINTAINER Danny Rawlins <contact at romster dot me>

VOLUME /var/cache/ccache
VOLUME /var/ports/packages
VOLUME /var/log/pkgbuild
VOLUME /usr/ports

ENV SHELL=/bin/sh

ADD prt-get.conf pkgmk.conf profile /etc/

ADD \
	http://crux.ster.zone/projects/crux/crux.asm \
	http://crux.ster.zone/projects/crux/Makefile \
	http://crux.ster.zone/projects/prt-ins/prt-ins-1.0.tar.xz \
	/tmp/

ADD https://crux.nu/portdb/?a=getup&q=romster /etc/ports/romster.httpup
ADD https://crux.nu/portdb/?a=getup&q=kde4 /etc/ports/kde4.rsync
ADD https://crux.nu/portdb/?a=getup&q=xfce /etc/ports/xfce.rsync
ADD https://crux.nu/portdb/?a=getup&q=enlightenment /etc/ports/enlightenment.rsync

# /usr/sbin/prt-ins
RUN \
	cd /tmp && \
	bsdtar -xf prt-ins-1.0.tar.xz && \
	cd prt-ins-1.0 && \
	make && \
	make install && \
	make clean && \
	cd / && \
	rm /tmp/prt-ins-1.0/* && \
	rmdir /tmp/prt-ins-1.0

# /usr/bin/crux
RUN \
	cd /tmp && \
	make && \
	make install && \
	make clean && \
	rm /tmp/{crux.asm,Makefile} && \
	cd -

RUN \
	prt-ins -i '/usr/ports/xorg' -p '/usr/ports/compat-32' && \
	prt-ins -i '/usr/ports/compat-32' -p '/usr/ports/contrib' && \
	prt-ins -i '/usr/ports/contrib' -p '/usr/ports/romster:pkg-not' && \
	prt-ins -i '/usr/ports/contrib' -p '/usr/ports/romster:pkg-url' && \
	prt-ins -i '/usr/ports/contrib' -p '/usr/ports/romster:check-32-versions' && \
	mkdir -p /var/ports/packages && \
	mv /etc/ports/contrib.rsync{.inactive,} && \
	mv /etc/ports/compat-32.rsync{.inactive,} && \
	ports -u core opt && \
	prt-get depinst vim ccache kmod httpup elfutils prt-utils && \
	prt-get remove elfutils && \
	prt-get sysup && \
	rm -r /usr/ports/{core,opt} /var/ports/packages/*

CMD . /etc/profile && /bin/sh
