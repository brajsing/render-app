FROM alpine:latest AS repo

# Set Git access token as an environment variable
# ENV GIT_ACCESS_TOKEN=<Give Your Aceses token>

# Install Git and clone private repository
# RUN apk --no-cache add git \
#     && git clone https://<You github username>:${GIT_ACCESS_TOKEN}@github.com<Complete github Url>

# Install Git and clone public repository
# https://github.com/Ismaestro/angular-example-app.git
ARG REPO=htest
RUN apk --no-cache add git \
    && git clone $REPO /repo

FROM node:18-alpine AS build

ARG INSTALL_CMD="npm install"
ARG BUILD_CMD="npm run build"
WORKDIR /usr/src/app

COPY --from=repo /repo /usr/src/app

RUN $INSTALL_CMD

# RUN $BUILD_CMD

# Expose port 3000
EXPOSE 3000

# Run app
CMD [ "node", "app/server" ]