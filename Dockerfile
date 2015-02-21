FROM crux:latest
MAINTAINER Danny Rawlins <contact at romster dot me>

VOLUME /var/cache/ccache
VOLUME /var/ports/packages
VOLUME /var/log/pkgbuild
VOLUME /usr/ports

ENV SHELL=/bin/sh

ADD prt-get.conf pkgmk.conf profile /etc/

RUN \
	mkdir -p /var/ports/packages && \
	mv /etc/ports/contrib.rsync{.inactive,} && \
	mv /etc/ports/compat-32.rsync{.inactive,} && \
	ports -u core opt && \
	prt-get depinst ccache kmod prt-utils && \
	prt-get sysup && \
	rm -r /usr/ports/{core,opt} /var/ports/packages/*

ADD \
	http://crux.ster.zone/projects/crux/crux.asm \
	http://crux.ster.zone/projects/crux/Makefile \
	/tmp/

RUN \
	cd /tmp && \
	make && \
	make install && \
	make clean && \
	rm /tmp/{crux.asm,Makefile} && \
	cd -

CMD . /etc/profile && /bin/sh
