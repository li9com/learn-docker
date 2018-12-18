FROM alpine:3.8

RUN mkdir -p /usr/src/app
RUN apk add curl
RUN curl -sO https://raw.githubusercontent.com/li9com/learn-docker/master/lab13-advanced-Dockerfile/package.json
RUN curl -sO https://raw.githubusercontent.com/li9com/learn-docker/master/lab13-advanced-Dockerfile/server.js
RUN mv package.json /usr/src/app/
RUN mv server.js /usr/src/app/

RUN apk add npm
RUN cd /usr/src/app && npm install

EXPOSE 8080
CMD cd /usr/src/app && npm start
