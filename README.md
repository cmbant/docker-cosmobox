### Overview

Docker with source build of the latest gcc/gfortran, plus latex, python 3, cfitsio
as needed for running building and running codes like CosmoMC, plotting and accessing astronomical data.

Currently gcc 6+ is required to run many Fortran 2003/2008 programs successfully due
to bugs in earlier versions. Also includes standard openmpi and lapack libraries,
useful basic python package configurations, as well as  basic build tools 
(inherited from the small cmbant/docker-gcc-build image). It can be used with Travis
for testing python/fortran/C codes.

GitHub: http://registry.hub.docker.com/u/cmbant/docker-cosmobox/
DockerHub: http://registry.hub.docker.com/u/cmbant/cosmobox/


### Usage

To make an interactive shell ready for compiling you local code at /local/code/source
do

    docker run -v /local/code/source:/virtual/path -i -t cmbant/docker-gcc-build /bin/bash

Navigating into /virtual/path in the bash shell, you can then run make etc as normal, acting
on your local files.
