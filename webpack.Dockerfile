# Dodgy solution to install locally
# sudo npm install -g --unsafe-perm bs-platform
# docker build -t react-reason .
# docker run --rm -d --name rr -p 8080:8080 react-reason:latest /bin/sh

FROM node:10.11.0-alpine

WORKDIR /src/react-ml

COPY package0.json ./package.json
RUN yarn
COPY webpack.config.js ./
CMD ["yarn", "webpack"]

EXPOSE 3000
