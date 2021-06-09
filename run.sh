#!/bin/sh
sudo docker build -t ruoyi-vue-preview .

sudo docker network create ruoyi-net
# todo docker网络部门文档查看

sudo docker run --rm -d --name mysql-server -v "$(pwd)"/sql:/docker-entrypoint-initdb.d --network ruoyi-net -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=ruoyi mysql:8.0.23

sudo docker run --rm -d --name redis-server --network ruoyi-net -d redis:6.2.4-alpine redis-server --appendonly yes

sudo docker run --rm -d --name ruoyi-appserv --network ruoyi-net -e REDIS_HOST=redis-server -e MYSQL_URL=jdbc:mysql://mysql-server/ruoyi -e MYSQL_USER=root -e MYSQL_PASSWORD=root -p 8080:8080 ruoyi-vue-preview