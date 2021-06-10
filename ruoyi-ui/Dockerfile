# syntax=docker/dockerfile:1
FROM node:14.16.1-alpine3.13
ENV NODE_ENV=development
WORKDIR /app
COPY package.json ./
RUN npm install --registry=https://registry.npm.taobao.org
COPY . .
CMD npm run dev