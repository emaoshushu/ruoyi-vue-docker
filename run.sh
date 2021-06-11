#!/bin/sh
sudo docker build -t ruoyi-vue-preview .

sudo docker network create ruoyi-net
# todo docker网络部门文档查看

sudo docker run --rm -d --name mysql-server -v "$(pwd)"/sql:/docker-entrypoint-initdb.d --network ruoyi-net -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=ruoyi -e LANG=C.UTF-8 mysql:8.0.23 --character-set-server=utf8mb4 --collation-server=utf8mb4_general_ci

sudo docker run --rm -d --name redis-server --network ruoyi-net -d redis:6.2.4-alpine redis-server --appendonly yes

sudo docker run --rm -d --name ruoyi-appserv --network ruoyi-net -e REDIS_HOST=redis-server -e MYSQL_URL=jdbc:mysql://mysql-server/ruoyi -e MYSQL_USER=root -e MYSQL_PASSWORD=root -p 8080:8080 ruoyi-vue-preview

sudo docker build -t ruoyi-vue-frontend-preview -f ./ruoyi-ui/Dockerfile ./ruoyi-ui

sudo docker run --rm -d --name ruoyi-vue --network ruoyi-net -e RUOYI_APP_SERV=ruoyi-appserv -p 8081:8081 ruoyi-vue-frontend-preview