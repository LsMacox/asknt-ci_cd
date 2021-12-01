#!/bin/bash

set -a


DIR_BACKEND='asknt-laravel-back-hpace'
DIR_FRONTEND='asknt-vue-front-hpace'

if [ ! -d "$DIR_BACKEND" ];
then
    git clone https://github.com/HPACE-IT-development/asknt-laravel-back-hpace.git
fi
if [ ! -d "$DIR_FRONTEND" ];
then
    git clone https://github.com/HPACE-IT-development/asknt-vue-front-hpace.git
fi

docker-compose down
docker-compose up -d nginx postgres postgres-postgis redis
docker-compose exec workspace bash -c 'cd /var/www/'"$DIR_BACKEND"' && ./build.sh'
echo 'initializing successful'
exit 0
