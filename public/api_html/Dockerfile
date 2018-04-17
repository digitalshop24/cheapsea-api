FROM alpine:3.6

MAINTAINER Roman Tarnavski

RUN apk add --update nginx

COPY nginx.conf /etc/nginx/
ADD ./dist/ /usr/share/nginx/html

EXPOSE 8080

CMD nginx -g 'pid /tmp/nginx.pid; daemon off;'