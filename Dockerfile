FROM crux:latest
MAINTAINER Danny Rawlins <contact at romster dot me>

VOLUME /var/cache/ccache

RUN \
	mv /etc/ports/contrib.rsync{.inactive,} && \
	mv /etc/ports/compat-32.rsync{.inactive,} && \
	sed \
		-e 's|^#\(prtdir /usr/ports/contrib\)|\1|' \
		-e 's|^#\(prtdir /usr/ports/compat-32\)|\1|' \
	-i /etc/prt-get.conf && \
	sed \
		-e 's|# runscripts no|runscripts yes|' \
		-e 's|# writelog enabled|writelog enabled|' \
		-e 's|# logmode  overwrite|logmode  overwrite|' \
		-e 's|# rmlog_on_success yes|rmlog_on_success yes|' \
		-i /etc/prt-get.conf && \
	echo 'export PATH="/usr/lib/ccache/:$PATH"' >> /etc/profile && \
	echo 'export CCACHE_DIR="/var/cache/ccache"' >> /etc/profile && \
	echo 'export CCACHE_COMPILERCHECK="%compiler% -dumpversion; crux"' >> /etc/profile && \
	. /etc/profile && \
	sed \
	-e 's|# export MAKEFLAGS="-j2"|export MAKEFLAGS="-j\$(/usr/bin/getconf _NPROCESSORS_ONLN)"|' \
	-e 's|# PKGMK_SOURCE_MIRRORS=()|PKGMK_SOURCE_MIRRORS=(http://10.0.0.1/distfiles/ http://crux.nu/distfiles/)|' \
	-e 's|# PKGMK_DOWNLOAD="no"|PKGMK_DOWNLOAD="yes"|' \
	-e 's|# PKGMK_IGNORE_NEW="no"|PKGMK_IGNORE_NEW="yes"|' \
	-e 's|# PKGMK_COMPRESSION_MODE="gz"|PKGMK_COMPRESSION_MODE="xz"|' \
	-i /etc/pkgmk.conf && \
	ports -u core opt && \
	prt-get depinst ccache kmod prt-utils && \
	prt-get sysup && \
	rm -r /usr/ports/{core,opt} && \
	cd /tmp && \
	wget http://crux.ster.zone/projects/crux/{crux.asm,Makefile} && \
	make && \
	make install && \
	make clean && \
	rm /tmp/{crux.asm,Makefile} && \
	cd -

CMD . /etc/profile && /bin/sh
