FROM yg397/thrift-microservice-deps:xenial

ARG NUM_CPUS=40

COPY ./ /media-microservices
RUN cd /media-microservices \
    && mkdir -p build \
    && thrift --gen lua media_service.thrift \
    && thrift --gen py media_service.thrift \
    && thrift --gen cpp media_service.thrift \
    && cd build \
    && cmake .. \
    && make -j${NUM_CPUS} \
    && make install

WORKDIR /media-microservices