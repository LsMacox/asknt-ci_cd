#!/bin/bash

set -a

if [ -f .env ]; then
    # Load Environment Variables
    export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
fi

DIR_BACKEND='asknt-laravel-back-hpace'
DIR_FRONTEND='asknt-vue-front-hpace'

if [ ! -d "$DIR_BACKEND" ];
then
    git clone https://"$GIT_USERNAME":"$GIT_OAUTH_TOKEN"@github.com/HPACE-IT-development/asknt-laravel-back-hpace.git
fi
if [ ! -d "$DIR_FRONTEND" ];
then
    git clone https://"$GIT_USERNAME":"$GIT_OAUTH_TOKEN"@github.com/HPACE-IT-development/asknt-vue-front-hpace.git
fi

docker-compose down
docker-compose up -d nginx postgres redis
docker-compose exec workspace bash -c 'cd /var/www/'"$DIR_BACKEND"' && chmod +x build.sh && ./build.sh'
docker-compose exec workspace bash -c 'cd /var/www/'"$DIR_FRONTEND"' && chmod +x build.sh && ./build.sh'
echo 'Initializing successful'
exit 0
