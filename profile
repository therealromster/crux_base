# cat /etc/profile 
#
# /etc/profile: system-wide defaults for bash(1) login shells
#

if [ "$UID" = "0" ]; then
	export PATH="/sbin:/usr/sbin:/opt/sbin:/bin:/usr/bin:/opt/bin"
else
	export PATH="/bin:/usr/bin:/opt/bin"
fi

if [ ! -f ~/.inputrc ]; then
	export INPUTRC="/etc/inputrc"
fi

export LESS="-R"
export PS1='\n\[\033[1;34m\]\u\[\033[0m\]@\[\033[1;31m\]\h\[\033[0m\]\n\[\033[0;32m\]\d \t\[\033[0m\]\n\[\033[1;37m\]\w\[\033[0m\]\n\$ '
export PS2='\[\033[1m\]> \[\033[0m\]'

umask 022

export PATH="/usr/lib/ccache/:$PATH"
export CCACHE_DIR="/var/cache/ccache"
export CCACHE_COMPILERCHECK="%compiler% -dumpversion; crux"

# End of file
