FROM kentwait/docker-openmpi
MAINTAINER Kent Kawashima <kentkawashima@gmail.com>

# Install utilities
RUN apt-get install -y wget bzip2 ca-certificates libglib2.0-0 libxext6 \
	libsm6 libxrender1 git mercurial subversion \
	curl grep sed dpkg

# Install anaconda 
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet http://repo.continuum.io/archive/Anaconda3-2.5.0-Linux-x86_64.sh && \
    /bin/bash /Anaconda3-2.5.0-Linux-x86_64.sh -b -p /opt/conda && \
    rm /Anaconda3-2.5.0-Linux-x86_64.sh

ENV PATH /opt/conda/bin:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# Install Python3 packages
conda install networkx
conda install seaborn
pip install simpy
pip install mpi4py

CMD [ "/bin/bash" ]