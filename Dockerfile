FROM msvc-wine:0.1

### NOTE: Taken from https://github.com/mstorsjo/msvc-wine/blob/cmake/Dockerfile.cmake
RUN apt-get update && \
    apt-get install -y --no-install-recommends git build-essential python3 python nasm

WORKDIR /opt

RUN git clone git://github.com/mstorsjo/ninja && \
    cd ninja && \
    git checkout 00ca3e147f55d00a178d0ec1b1268c6793be3e16 && \
    ./configure.py --bootstrap

ENV PATH=/opt/ninja:$PATH

WORKDIR /build
RUN git clone https://gitlab.kitware.com/mstorsjo/cmake.git && \
    cd cmake && \
    git checkout 844ccd2280d11ada286d0e2547c0fa5ff22bd4db && \
    mkdir build && \
    cd build && \
    ../configure --prefix=/opt/cmake --parallel=$(nproc) -- -DCMAKE_USE_OPENSSL=OFF && \
    make -j$(nproc) && \
    make install

ENV PATH=/opt/cmake/bin:$PATH

###

ENV UNAME=wine
ARG UID
ARG GID
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
RUN mkdir -p /home/$UNAME/.wine && chown -R $UNAME:$UNAME /home/$UNAME
USER $UNAME

ENV PATH=/opt/msvc/bin/x86:$PATH

WORKDIR /home/wine

COPY wine-msvc.sh /opt/msvc/bin/x86/wine-msvc.sh

