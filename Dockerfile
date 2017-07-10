FROM cmbant/docker-gcc-build:gcc6

MAINTAINER Antony Lewis

#Install latex and python (skip pyside, assume only command line)
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
 texlive dvipng texlive-latex-extra texlive-fonts-recommended \
 python-pip \
 python-setuptools \
 python-dev \
 python-numpy \
 python-matplotlib \
 python-scipy \
 python-pandas \
 python-sympy \
 cython \
 ipython \
 wget \
 && apt-get clean

# In case want to run starcluster from here
#RUN pip install starcluster

#Install cfitsio library for reading FITS files
RUN oldpath=`pwd` && cd /tmp \
&& wget ftp://heasarc.gsfc.nasa.gov/software/fitsio/c/cfitsio_latest.tar.gz \
&& tar zxvf cfitsio_latest.tar.gz \
&& cd cfitsio \
&& ./configure --prefix=/usr \
&& make -j 2 \
&& make install \
&& make clean \
&& cd $oldpath \
&& rm -Rf /tmp/cfitsio* 