FROM cmbant/docker-gcc-build:devel

MAINTAINER Antony Lewis


#Install latex and python (skip pyside, assume only command line)
RUN apt-get update \
 && apt-get install -y --no-install-recommends apt-utils \
 && apt-get install -y --no-install-recommends \
 texlive dvipng texlive-latex-extra texlive-fonts-recommended \
 && apt-get clean

ENV PATH="/opt/conda/bin:${PATH}"
CMD [ "/bin/bash" ]

RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh \
 && bash miniconda.sh -b -p /opt/conda \
 && rm -f miniconda.sh \
 && /opt/conda/bin/conda install --yes conda \
 && conda info -a \
 && conda install -c conda-forge --yes conda-build atlas numpy scipy matplotlib pandas sympy cython ipython yaml \
 && conda clean --yes -i -t -l -s -p


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