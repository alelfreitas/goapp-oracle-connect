# FROM atf.intranet.bb.com.br:5001/bb/lnx/lnx-alpine:3.11.3
FROM centos:centos8

ARG ARQUIVO_BASIC=instantclient-basiclite-linux.x64-19.6.0.0.0dbru.zip

ENV \
     DEBIAN_FRONTEND=noninteractive \
     TZ=Brazil/East \
     LD_LIBRARY_PATH=/usr/lib/oracle/instantclient_19_6:$LD_LIBRARY_PATH \
     PATH=$PATH:/usr/lib/oracle/instantclient_19_6

WORKDIR /usr/lib/oracle

COPY ./.lib/oracle/${ARQUIVO_BASIC} /usr/lib/oracle

RUN \ 
     yum install -y libaio && \
     unzip ${ARQUIVO_BASIC} && \
     rm -rf ${ARQUIVO_BASIC} && \
     sh -c "echo /opt/oracle/instantclient_19_6 > /etc/ld.so.conf.d/oracle-instantclient.conf" && \
     ldconfig /etc/ld.so.conf.d

COPY .lib/oracle/oci8.pc /usr/lib/pkgconfig

WORKDIR /opt/app
COPY image.json image.json
COPY bin/tsb-titulos tsb-titulos
RUN chmod +x tsb-titulos
CMD [ "/opt/app/tsb-titulos" ]
