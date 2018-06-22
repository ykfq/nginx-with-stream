#!/usr/bin/env bash

#funtion
Usage(){
    echo "Usage:"
    echo "$0 [version]"
    echo "Example:"
    echo "  $0 17.12.1"
    echo "If version doesn't specified, the latest will be installed."
}

#funtion
get_latest_release() {
  curl --silent "https://api.github.com/repos/docker/docker-ce/releases/latest" | \
  grep tag_name | awk -F "\"v" '{print $2}' | awk -F"-ce" '{print $1}'
}

# check env
echo
if [[ -z "$1" ]]; then
    echo "Get the latest version of docker-ce, see https://github.com/docker/docker-ce/releases"
    DOCKER_VERSION=$(get_latest_release)
    echo "$DOCKER_VERSION"
else
    DOCKER_VERSION=$1
fi

echo
DOCKER_URL=https://mirrors.aliyun.com/docker-ce/linux/centos/7/x86_64/stable/Packages/docker-ce-${DOCKER_VERSION}.ce-1.el7.centos.x86_64.rpm
curl --output /dev/null --silent --head --fail ${DOCKER_URL}
if [[ $? != 0 ]]; then
    echo "Wrong version, docker-ce-${DOCKER_VERSION} does not exists, exit"
    exit 1
else
    echo "Find docker-ce-${DOCKER_VERSION}, install it now..."
    yum -y install ${DOCKER_URL}
fi

echo
echo "Generate docker daemon.json now..."
[[ ! -d /etc/docker ]] && mkdir -p /etc/docker
[[ ! -d /data/docker/storage ]] && mkdir -p /data/docker/storage
cat > /etc/docker/daemon.json << EOF
{
  "bip":"10.0.0.1/24",
  "ipv6":false,
  "data-root": "/data/docker/storage/"
}
EOF

export PATH=$PATH:/usr/local/bin

docker -v 2>/dev/null 1>&2
[[ $? != 0 ]] && echo "docker not found, check it please." && exit 1

echo "docker installed succuesfully."
echo "$(docker version)"

