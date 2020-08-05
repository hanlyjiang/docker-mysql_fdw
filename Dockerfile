FROM postgres:9.5-alpine as fdw_builder

ARG MYSQL_FDW_VERSION=REL-2_5_4

WORKDIR /tmp
RUN apk update && apk add --no-cache\
  git \
  gcc \
  libc-dev \
  make \
  mysql-dev
RUN git clone -b "${MYSQL_FDW_VERSION}" https://github.com/EnterpriseDB/mysql_fdw.git

WORKDIR /tmp/mysql_fdw
# fix build error in mysql_fdw.c
# https://github.com/EnterpriseDB/mysql_fdw/issues/187
RUN sed -i 's/ | RTLD_DEEPBIND//' mysql_fdw.c
RUN make USE_PGXS=1 && make USE_PGXS=1 install


FROM postgres:9.5-alpine

COPY --from=fdw_builder /usr/local/lib/postgresql/mysql_fdw.so /usr/local/lib/postgresql/
COPY --from=fdw_builder /usr/local/share/postgresql/extension/mysql_fdw* /usr/local/share/postgresql/extension/
COPY --from=fdw_builder /usr/lib/libmysqlclient.so /usr/lib/
