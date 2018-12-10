FROM alpine:3.8

RUN mkdir -p /usr/src/app
RUN curl -sO https://raw.githubusercontent.com/li9com/learn-docker/b2af04f10c2fc983e9a43737afbcf16da33591e4/lab13-advanced-Dockerfile/package.json
RUN curl -sO https://raw.githubusercontent.com/li9com/learn-docker/afc100a7450b8f6810f397b7b172499f38bd48fa/lab13-advanced-Dockerfile/server.js
RUN mv package.json /usr/src/app/
RUN mv server.js /usr/src/app/

RUN apk add --no-cache curl npm
RUN cd /usr/src/app && npm install

EXPOSE 8080
CMD cd /usr/src/app && npm start
