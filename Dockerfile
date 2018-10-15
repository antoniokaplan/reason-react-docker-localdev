# Dodgy solution to install locally
# sudo npm install -g --unsafe-perm bs-platform
# docker build -t react-reason .
# docker run --rm -d --name rr -p 8080:8080 react-reason:latest /bin/sh
FROM node:10.11.0-alpine
ARG appdir=/usr/app
ARG npmg=$appdir/.npmglobal

# Switch to root user to install container dependencies
USER root
RUN apk update && apk upgrade && \
    apk add build-base bzip2 git tar curl ca-certificates python ocaml-runtime ocaml

# create an `app` user & create .npmglabl repo to install global dependency for `bs-platform`
RUN addgroup -S app && adduser -S -G app app
RUN mkdir -p $npmg && mkdir -p $npmg/bin && mkdir -p $appdir/react-ml
RUN chown -R app $npmg

# Configure npm to use the new global install directory with permissions
USER app
RUN npm config set prefix $npmg
ENV PATH=$npmg/bin:$PATH
RUN npm install -g bs-platform

USER root
WORKDIR $appdir/react-ml
# RUN bsb -init react-ml -theme react
RUN npm link bs-platform
COPY package.json ./
RUN yarn

RUN mkdir -p build && mkdir -p src && mkdir -p lib
COPY bsconfig.json webpack.config.js ./
COPY reason-source/src/index.html ./build/index.html

CMD ["yarn", "develop"]

# RUN yarn add webpack@~4 webpack-cli@~3

# VOLUME $appdir
# RUN chmod 0777 $appdir/react-ml/startup.sh
# RUN cat $appdir/react-ml/package.json
# CMD ["yarn", "start"]
# ENTRYPOINT [ "sh", "-c", "yarn start" ]

# RUN yarn start > myapp.log 2>&1 &
# && yarn start > myapp.log 2>&1 && yarn we
# RUN yarn webpack
# RUN chown root $appdir/react-ml/startup.sh
# USER root
# CMD ["yarn", "develop"]
# USER app
# ENTRYPOINT ["yarn start | yarn webpack"]
#

#docker run -it -v $(pwd)/reason-source/src:/usr/app/react-ml/src -v $(pwd)/reason-source/build:/usr/app/react-ml/build  react-reason /bin/sh
#docker run --rm --name react -d -p 8000:8000 -v $(pwd)/reason-source:/usr/app/react-ml react-reason

# WORKING
# docker run --rm --name react -d -v $(pwd)/reason-source/src:/usr/app/react-ml/src -v $(pwd)/reason-source/build:/usr/app/react-ml/build  react-reason sh -c 'yarn webpack | yarn start'
# docker run -it -v $(pwd)/reason-source/src:/usr/app/react-ml/src -v $(pwd)/reason-source/build:/usr/app/react-ml/build  react-reason /bin/sh
