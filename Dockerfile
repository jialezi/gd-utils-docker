FROM alpine
MAINTAINER Tdtool
ARG VERSION=2020-08-24

ENV USERPWD mysec55rdet9966
ENV Domain aaa.com
USER root

ADD start.sh /
COPY alpine.patch /alpine.patch



RUN set -ex \
        && apk update \
        && apk add --no-cache nodejs npm  \
		&& apk add ca-certificates mailcap curl bash \
        && apk add --no-cache --virtual .build-deps make gcc g++ python3 git \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone

ARG VERSION
RUN set -ex \
        && git clone https://github.com/iwestlin/gd-utils /gd-utils \
        && cd /gd-utils \
        && npm install \
        && apk del .build-deps


RUN apk add --no-cache --update --virtual build-deps alpine-sdk autoconf automake libtool curl tar git && \
        adduser -D -H shusr && \
        git clone https://github.com/shellinabox/shellinabox.git /shellinabox && \
        cd /shellinabox && \
        git apply /alpine.patch && \
        autoreconf -i && \
        ./configure --prefix=/shellinabox/bin && \
        make && make install && cd / && \
        mv /shellinabox/bin/bin/shellinaboxd /usr/local/bin/shellinaboxd && \
        rm -rf /shellinabox && \
        rm -rf /etc/nginx/conf.d/default.conf && \
        apk del build-deps && rm -rf /var/cache/apk/
COPY caddy //usr/local/bin/
COPY Caddyfile /gd-utils/
COPY filebrowser.json /.filebrowser.json
RUN curl -fsSL https://filebrowser.xyz/get.sh | bash
RUN chmod +x /start.sh && \
	chmod 777 /usr/local/bin/shellinaboxd
#添加gd账号,设置密码
#RUN  adduser  gd -u 20001 -D -S -s /bin/bash -G root && \
#	echo -e "${USERPWD}\n${USERPWD}" | passwd root && \
#	echo -e "${USERPWD}\n${USERPWD}" | passwd gd && \
#	chmod 4755 /bin/busybox	
EXPOSE 443 23333 4200 80 8080
VOLUME /gd-utils


ENTRYPOINT [ "/start.sh" ]
