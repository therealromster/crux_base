# crux_base
Base crux docker image with a few modfications for testing packages in.

There are a few alterations from crux:latest, here are the major changes:

Source mirrors
Logging on by default
Using a system cache for speed up compiles
Default number of make jobs to number of CPU cores
Use xz compression on packages
