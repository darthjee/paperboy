#!/bin/bash

function isLatestCommit() {
  VERSION=$(git tag | grep $(git describe  --tags))

  if [[ $VERSION ]]; then
    return 0
  else
    return 1
  fi
}

function checkLastCommit() {
  if [ $FORCE_RELEASE ]; then
    return 0;
  fi

  if $(isLatestCommit); then
    echo "latest commit";
  else
    echo "Not last commit"
    exit 0;
  fi
}

function releaseLocal() {
  VERSION=$(git describe --tags --abbrev=0)
  docker tag darthjee/paperboy:latest darthjee/paperboy:$VERSION
  docker push darthjee/paperboy:latest
  docker push darthjee/paperboy:$VERSION
}

checkLastCommit

ACTION=$1

case $ACTION in
  "install")
    curl https://cli-assets.heroku.com/install.sh | sh
    ;;
  "set-app")
    heroku git:remote -a "$HEROKU_APP_NAME"
    ;;
  "signin")
    heroku container:login
    ;;
  "build")
    make PROJECT=production_paperboy build
    ;;
  "build-heroku")
    make build-heroku
    ;;
  "release")
    make release
    ;;
  "migrate")
    heroku run rake db:migrate
    ;;
  "populate")
    heroku run rake populate:all
    ;;
  "build-local")
    make PROJECT=paperboy build
    ;;
  "release-local")
    releaseLocal
    ;;
  *)
    echo Usage:
    echo "$0 build # builds gem"
    echo "$0 push # pushes gem"
    ;;
esac
