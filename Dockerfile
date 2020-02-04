FROM ubuntu:18.04
# build using: sudo docker build --tag texlive-container .

WORKDIR /texlive-files
ADD texlive.profile /texlive-files

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade -y
RUN apt install -y wget perl python3 python3-distutils
# perl is required to install texlive
# python3 and python3-distutils are required for rubber

RUN wget https://launchpad.net/rubber/trunk/1.5.1/+download/rubber-1.5.1.tar.gz || exit 1
RUN echo "37a843dc36a8aa256f9a66de130a031a0406346e663e1c257e45fd0a6eae0d9d  rubber-1.5.1.tar.gz" | sha256sum --check || exit 1
RUN tar -xf rubber-1.5.1.tar.gz
RUN cd rubber-1.5.1 && python3 setup.py build --info=False --html=False --pdf=False install

RUN wget "ftp://tug.org/historic/systems/texlive/2019/install-tl-unx.tar.gz" || exit 1
RUN echo "44aa41b5783e345b7021387f19ac9637ff1ce5406a59754230c666642dfe7750  install-tl-unx.tar.gz" | sha256sum --check || exit 1
RUN tar -xf install-tl-unx.tar.gz

RUN cd install-tl-20* && ./install-tl --profile=../texlive.profile 2>&1 | tee outfile
# --repository ftp://tug.org/historic/systems/texlive/2019/tlnet-final
ENV PATH="/usr/local/texlive/2019/bin/x86_64-linux:${PATH}"

WORKDIR /host-volume
# this is the directory that is shared with the host using the '-v' option for docker run
