FROM ubuntu:16.04
LABEL maintainer="Belcour A."
LABEL Version="0.1"
LABEL Description="Clingo dockerfile with Python3.5 and Lua5.3."

RUN apt-get -y update && \ 
    apt-get -y install \
    build-essential \
    cmake \ 
    bison \
    re2c \
    doxygen \
    git \
    python3.5-dev \
    lua5.3-dev

RUN mkdir /programs;\
# Install Clingo with Python3.5 and Lua5.3.
    cd /tmp;\
    git clone https://github.com/potassco/clingo.git;\
    cd clingo;\
    git submodule update --init --recursive;\
    cmake -H. -B/programs/clingo -DCMAKE_BUILD_TYPE=Release -DCLINGO_BUILD_WITH_PYTHON=On -DPYTHON_EXECUTABLE=/usr/bin/python3.5;\
    cmake --build /programs/clingo;\
    echo 'export PATH="$PATH:/programs/clingo/bin:"' >> ~/.bashrc;\

# Clean temporary data.
    rm -r /tmp/clingo;\
    apt-get clean
