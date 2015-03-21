# crux_base
Base crux docker image with a few modifications for testing packages in.

There are a few alterations from crux:latest, here are the major changes:

Source mirrors, logging on by default, using a system cache for speed up compiles, default number of make jobs to number of CPU cores, and use xz compression on packages.

```
PKG_PORT=foo

mkdir -p $HOME/docker/crux/${PKG_PORT}/{packages,log,ports}

docker run -i -t -v /var/cache/ccache:/var/cache/ccache \
-v $HOME/docker/crux/${PKG_PORT}/log:/var/log/pkgbuild \
-v $HOME/docker/crux/${PKG_PORT}/packages:/var/ports/packages \
-v $HOME/docker/crux/${PKG_PORT}/ports:/usr/ports \
--name="${PKG_PORT}" romster/crux-base
```
