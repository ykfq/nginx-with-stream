# nginx-with-stream
build nginx-with-stream in docker

## nginx version: 1.12.2 (current stable)

## nginx main config
> /etc/nginx/nginx.conf

see here [nginx.conf](https://github.com/ykfq/nginx-with-stream/blob/master/conf/nginx.conf)

## nginx custom config
- http conf
  > /etc/nginx/conf.d/
- stream conf
  > /etc/nginx/conf.d.stream

# How to use
```
git clone git@github.com:ykfq/nginx-with-stream.git
cd nginx-with-stream
docker build --tag ykfq/nginx-with-stream:1.12.2
docker run --name nginx-with-stream ykfq/nginx-with-stream
```
