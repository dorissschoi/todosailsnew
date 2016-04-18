FROM node:4-slim

WORKDIR /usr/src/app

ADD https://github.com/dorissschoi/todosailsnew/archive/master.tar.gz /tmp

RUN apt-get update && \ 
	apt-get clean && \
	cd /usr/src/app && \
	tar --strip-components=1 -xzf /tmp/master.tar.gz && \
	rm /tmp/master.tar.gz && \ 
	npm install coffee-script -g && \
	npm install && \
	ln -s /usr/local/bin/coffee /usr/bin/coffee 

ENTRYPOINT npm start --prod