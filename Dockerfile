FROM frolvlad/alpine-glibc:alpine-3.12

ARG URL_INSTANT_CLIENT=https://download.oracle.com/otn_software/linux/instantclient/19800/
ARG BASIC_VER_FOLDER=instantclient_19_8
ARG FILE_BASIC=instantclient-basic-linux.x64-19.8.0.0.0dbru.zip

ENV \
     LD_LIBRARY_PATH=/usr/lib/oracle/${BASIC_VER_FOLDER}:$LD_LIBRARY_PATH \
     PATH=$PATH:/usr/lib/oracle/${BASIC_VER_FOLDER}

WORKDIR /usr/lib/oracle

RUN \
     apk add libaio && \
     mkdir /etc/ld.so.conf.d && \
     wget ${URL_INSTANT_CLIENT}${FILE_BASIC} && \
     unzip ${FILE_BASIC} && \
     rm -rf ${FILE_BASIC} && \
     sh -c "echo /opt/oracle/${BASIC_VER_FOLDER} > /etc/ld.so.conf.d/oracle-instantclient.conf" && \
     ldconfig /etc/ld.so.conf.d

COPY oci8.pc /usr/lib/pkgconfig