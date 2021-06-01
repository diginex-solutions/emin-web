FROM nginx:alpine
RUN apk add -U bash
COPY default.conf /etc/nginx/conf.d/
COPY eminweb/build/web /usr/share/nginx/html
