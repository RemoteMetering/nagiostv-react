FROM docker-registry.rmsconnect.net/rms-node:alpine

# Arguments
ARG REACT_APP_KEYCLOAK_URL
ARG REACT_APP_KEYCLOAK_REALM
ARG REACT_APP_NODE_ENV

# Create app directory
RUN mkdir -p /usr/app/log

# Build
RUN mkdir /usr/build
COPY . /usr/build/
RUN cd /usr/build && \
	yarn install && \
	yarn build && \
	cd /usr && \
	cp -a /usr/build/build/. /usr/app/ && \
	rm -rf /usr/build && \
	yarn global add serve && \
	yarn cache clean

# Entrypoint
WORKDIR /usr/app
EXPOSE 3000
CMD ["serve", "-p", "3000","-s"]