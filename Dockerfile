FROM cmbant/docker-gcc-build:gcc8

MAINTAINER Antony Lewis

#Install latex and python (skip pyside, assume only command line)
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
 texlive dvipng texlive-latex-extra texlive-fonts-recommended \
 wget \
 build-essential \
 && apt-get clean

ENV PATH="/opt/conda/bin:${PATH}"
CMD [ "/bin/bash" ]

RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh \
 && bash miniconda.sh -b -p /opt/conda \
 && rm -f miniconda.sh \
 && /opt/conda/bin/conda install --yes conda \
 && conda info -a \
 && conda install --yes scipy matplotlib pandas sympy cython ipython jupyter PyYAML packaging \
 && conda clean --yes -i -t -s -p


# In case want to run starcluster from here
#RUN pip install starcluster

#Install cfitsio library for reading FITS files
RUN oldpath=`pwd` && cd /tmp \
&& wget https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio3280.tar.gz \
&& tar zxvf cfitsio3280.tar.gz \
&& rm -f cfitsio3280.tar.gz \
&& cd cfitsio* \
&& ./configure --prefix=/usr \
&& make -j 2 \
&& make install \
&& make clean \
&& cd $oldpath \
&& rm -Rf /tmp/cfitsio* 
