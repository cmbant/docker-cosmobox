FROM cmbant/docker-gcc-build:latest

MAINTAINER Antony Lewis

#Install latex and python (skip pyside, assume only command line)
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
 texlive dvipng texlive-latex-extra texlive-fonts-recommended \
# python-pip \
# python-setuptools \
# python-dev \
# python-numpy \
# python-matplotlib \
# python-scipy \
# python-pandas \
# python-sympy \
# cython \
# ipython \
 wget \
 build-essential \
 && apt-get clean
 
 RUN wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O miniconda.sh \
 && bash miniconda.sh -b -p $HOME/miniconda \
 && export PATH="$HOME/miniconda/bin:$PATH" \
 && hash -r \
 && conda config --set always_yes yes --set changeps1 no \
 && conda update -q conda \
 && conda info -a \
 && conda create -q -n cosmobox-environment python=2.7 atlas numpy scipy matplotlib pandas sympy cython ipython \
 && /bin/bash source activate cosmobox-environment \
 && rm -f miniconda.sh

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