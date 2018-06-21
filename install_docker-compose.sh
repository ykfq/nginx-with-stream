#!/usr/bin/env bash

#funtion
Usage(){
    echo "Usage:"
    echo "$0 [version]"
    echo "Example:"
    echo "  $0 1.21.2"
    echo "If a version does not specified, the latest version will be installed."
}

#funtion
get_latest_release() {
  curl --silent "https://api.github.com/repos/docker/compose/releases/latest" | \
  grep tag_name | awk -F "\"" '{print $4}'
}

# check env
if [[ -z "$1" ]]; then
    echo "Get the latest version of docker-compose, see https://github.com/docker/compose/releases"
    COMPOSE_VERSION=$(get_latest_release)
    echo "$COMPOSE_VERSION"
else
    COMPOSE_VERSION=$1
fi

curl -L -o /usr/local/bin/docker-compose \
 https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m`

[[ $? != 0 ]] && echo "Download docker-compose error, exit." && exit
chmod +x /usr/local/bin/docker-compose

export PATH=$PATH:/usr/local/bin

docker-compose version 2>/dev/null 1>&2
[[ $? != 0 ]] && echo "docker-compose not found, check it." && exit 1

echo "docker-compose installed succuesfully."
echo "$(docker-compose version)"

