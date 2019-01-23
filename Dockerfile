# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: glibc
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM        node:8-alpine

LABEL       author="BierqueJason" maintainer="bierquejason@gmail.com"

RUN         apk add --no-cache --update alpine-sdk pixman cairo pango giflib ca-certificates libjpeg-turbo-dev libc6-compat ffmpeg python git make pkgconfig autoconf automake libtool bison flex\
&& apk add --no-cache --virtual .build-deps git curl build-base jpeg-dev pixman-dev cairo-dev pango-dev pangomm-dev giflib-dev freetype-dev g++ \
            && adduser -D -h /home/container container
            
RUN apk add --update fontconfig wqy-zenhei --update-cache --repository http://nl.alpinelinux.org/alpine/edge/testing --allow-untrusted
RUN apk add --update ttf-dejavu fontconfig 
RUN apk --no-cache add --update font-adobe-100dpi ttf-dejavu msttcorefonts-installer fontconfig && \
update-ms-fonts && \
fc-cache -f

COPY ./fonts/ /usr/share/fonts/
RUN chmod a+r /usr/share/fonts/PingFang.ttf

USER        container
ENV         USER=container HOME=/home/container
ENV PKG_CONFIG_PATH="/usr/lib/pkgconfig/:/usr/local/lib/pkgconfig/:/usr/local/lib/libgit2/lib/pkgconfig:/usr/local/lib/openssl/lib/pkgconfig:/usr/local/lib/libssh2:/usr/include/"
WORKDIR     /home/container
COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/ash", "/entrypoint.sh"]
