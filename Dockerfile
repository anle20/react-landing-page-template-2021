# module install
FROM node:14 as module-install-stage
# set working directory
WORKDIR /app

COPY package.json /app/package.json

RUN yarn

# build
FROM node:14 as build-stage
COPY --from=module-install-stage /app/node_modules/ /app/node_modules
WORKDIR /app
COPY . .
RUN yarn build

# serve
FROM node:14
WORKDIR /app
COPY --from=build-stage /app /app
CMD ["yarn", "start"]
EXPOSE 3000
