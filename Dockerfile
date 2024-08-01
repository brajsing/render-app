FROM alpine:latest AS repo

# Set Git access token as an environment variable
# ENV GIT_ACCESS_TOKEN=<Give Your Aceses token>

# Install Git and clone private repository
# RUN apk --no-cache add git \
#     && git clone https://<You github username>:${GIT_ACCESS_TOKEN}@github.com<Complete github Url>

# Install Git and clone public repository
RUN apk --no-cache add git \
    && git clone https://github.com/Ismaestro/angular-example-app.git /repo

FROM node:18-alpine AS build

WORKDIR /usr/src/app

COPY --from=repo /repo /usr/src/app

RUN npm install -g @angular/cli

RUN npm install

RUN npm run build

# Stage 2, use the compiled app, ready for production with Nginx
FROM nginx
COPY --from=build /usr/src/app/dist/ /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf