ARG IMAGE_NAME
ARG SOURCE_BRANCH
ARG SOURCE_COMMIT

FROM gcc:latest

MAINTAINER Antony Lewis

LABEL org.label-schema.name="cosmobox" \
      org.label-schema.url="https://github.com/cmbant/docker-cosmobox/tree/$SOURCE_BRANCH" \
      org.label-schema.version="$SOURCE_COMMIT" \
      org.label-schema.docker.cmd="docker run -v $(pwd):/virtual/path -i -t $IMAGE_NAME /bin/bash"

#Install latex and python (skip pyside, assume only command line)
RUN apt-get update \
 && apt-get install -y --no-install-recommends apt-utils \
 && apt-get install -y --no-install-recommends \
 texlive dvipng texlive-latex-extra texlive-fonts-recommended \
 && apt-get clean

ENV PATH="/opt/conda/bin:${PATH}"

RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh \
 && bash miniconda.sh -b -p /opt/conda \
 && rm -f miniconda.sh \
 && /opt/conda/bin/conda install --yes conda \
 && conda info -a \
 && conda install -c conda-forge --yes conda-build numpy scipy matplotlib pandas sympy cython ipython PyYAML numba packaging swig fftw gsl cmake \
 && conda clean --yes -i -t -p


#Install cfitsio library for reading FITS files
RUN oldpath=`pwd` && cd /tmp \
&& wget https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio3280.tar.gz \
&& tar zxvf cfitsio3280.tar.gz \
&& cd cfitsio* \
&& ./configure --prefix=/usr \
&& make -j 2 \
&& make install \
&& make clean \
&& cd $oldpath \
&& rm -Rf /tmp/cfitsio* 


CMD [ "/bin/bash" ]
