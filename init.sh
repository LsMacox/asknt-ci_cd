#!/bin/bash

set -a

if [ ! -f .env ]; then
    cp .env.example .env
fi

DIR_BACKEND='asknt-laravel-back-hpace'
DIR_FRONTEND='asknt-vue-front-hpace'

if [ ! -d "$DIR_BACKEND" ];
then
    git clone https://"$GIT_USERNAME":"$GIT_OAUTH_TOKEN"@github.com/HPACE-IT-development/asknt-laravel-back-hpace.git
    cd asknt-laravel-back-hpace || exit
    cp .env.example .env
    cd ..
fi
if [ ! -d "$DIR_FRONTEND" ];
then
    git clone https://"$GIT_USERNAME":"$GIT_OAUTH_TOKEN"@github.com/HPACE-IT-development/asknt-vue-front-hpace.git
    cd asknt-vue-front-hpace || exit
    cp .env.example .env
    cd ..
fi

if [ -d "$DIR_BACKEND" ] && [ -d "$DIR_FRONTEND" ];
then
  docker-compose down
  docker-compose up -d nginx postgres redis
  docker-compose exec workspace bash -c 'cd /var/www/'"$DIR_BACKEND"' && chmod +x build.sh && ./build.sh'
  docker-compose exec workspace bash -c 'cd /var/www/'"$DIR_FRONTEND"' && chmod +x build.sh && ./build.sh'
  echo 'Initializing successful'
  exit 0
fi

