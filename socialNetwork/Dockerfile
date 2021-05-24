FROM yg397/thrift-microservice-deps:xenial

ARG NUM_CPUS=40

COPY ./ /social-network-microservices
RUN cd /social-network-microservices \
    && thrift --gen lua social_network.thrift \
    && thrift --gen cpp social_network.thrift \
    && thrift --gen py social_network.thrift \
    && mkdir -p build \
    && cd build \
    && cmake -DCMAKE_BUILD_TYPE=Debug .. \
    && make -j${NUM_CPUS} \
    && make install

WORKDIR /social-network-microservices