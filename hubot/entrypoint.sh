#!/bin/sh
set -e

if [[ "$1" == "hubot" ]]; then

    /hubot/bin/hubot --adapter slack

else

    "$@"
    
fi

