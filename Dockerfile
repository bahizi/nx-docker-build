ARG NODE_VER=14.18.2
FROM node:${NODE_VER}-alpine3.14 as base

# Add an app user to run our application so that it doesn't need to run as root
RUN adduser -D -s /bin/sh airline

# set working directory
WORKDIR /home/airline
ENV CYPRESS_INSTALL_BINARY=0

# copy project file
COPY . .

RUN npm install

# With @nrwl/workspace@13.4.6 the following build command will fail since our base image doesn't have git installed.
# @nrwl/workspace@13.4.5 works (see the fix/docker-build branch).
RUN npm run ng run api:build
EXPOSE 3000

CMD ["node", "dist/apps/api/main.js"]
