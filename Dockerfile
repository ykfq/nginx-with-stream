FROM centos:7.4.1708

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

#Set ENV
ARG NGINX_VERSION=1.12.2
ENV NGINX_VERSION=${NGINX_VERSION}

RUN \
    echo "Asia/shanghai" > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    rm -f /etc/yum.repos.d/* && \
    curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && \
    curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo && \
    yum -y install net-tools iproute bind-utils telnet wget

#install nginx
RUN yum -y install nginx-${NGINX_VERSION} && \
    rm -rf /var/cache/yum

ADD conf/nginx.conf /etc/nginx/

EXPOSE 80 443

VOLUME /etc/nginx/conf.d.stream/

#run squid when container created
CMD ["nginx", "-g", "daemon off;"]
