# Run nginx adnd ssr using docker-compose
> Note: This repo is for CentOS 7.x only.

## nginx-with-stream
build nginx-with-stream in docker

### nginx version: 1.12.2 (current stable)

### nginx main config
> /etc/nginx/nginx.conf

see here [nginx.conf](https://github.com/ykfq/nginx-with-stream/blob/master/conf/nginx.conf)

### nginx custom config
- http conf
  > /etc/nginx/conf.d/
- stream conf
  > /etc/nginx/conf.d.stream

## SSR
Install SSR in CentOS 6+, Debian7+, Ubuntu12+

### Thanks to [teddysun](https://teddysun.com/486.html)
The `ssr.sh` script was based on [shadowsocks_install](https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh) and had some changes:

- Removed all other ss versions except SSR;
- Make the script ask for values instead of read from stdin so that we can pass them from Dockefile;
  Thanks @ https://stackoverflow.com/a/50195430/5723841
- Simple change of shadowsocks-r to support running foreground in docker; 


# How to use
```
git clone git@github.com:ykfq/nginx-with-stream.git
cd nginx-with-stream
```

## Install docker-ce
```
bash install_docker-ce.sh
```

## Install docker-compose
```
bash install_docker-compose.sh
```

## Run containers
```
docker-compose down; docker-compose up --build -d
```
