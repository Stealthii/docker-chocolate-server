#!/bin/sh
set -e

PATH="/usr/games:${PATH}"

PARAMS=""

if [ -n ${servername+x} ]; then
    PARAMS="${PARAMS} -servername \"$servername\""
fi

if [ -n ${port+x} ]; then
    PARAMS="${PARAMS} -port $port"
fi

if [ "$privateserver" = true ]; then
    PARAMS="${PARAMS} -privateserver"
fi

if [ "$newsync" = true ]; then
    PARAMS="${PARAMS} -newsync"
fi

exec chocolate-server ${PARAMS} $@
