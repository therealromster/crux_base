# crux_base
Base crux docker image with a few modifications for testing packages in.

There are a few alterations from crux:latest, here are the major changes:

Source mirrors, logging on by default, using a system cache for speed up compiles, default number of make jobs to number of CPU cores, and use xz compression on packages.

docker run -i -t -v /var/cache/ccache:/var/cache/ccache romster/crux-base
