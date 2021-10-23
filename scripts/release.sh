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
  if $(isLatestCommit); then
    echo "latest commit";
  else
    echo "Not last commit"
    exit 0
  fi
}

ACTION=$1

case $ACTION in
  "install")
    checkLastCommit
    curl https://cli-assets.heroku.com/install.sh | sh
    ;;
  "set-app")
    checkLastCommit
    heroku git:remote -a $HEROKU_APP_NAME
    ;;
  "signin")
    checkLastCommit
    heroku container:login
    ;;
  "build")
    checkLastCommit
    make PROJECT=production_paperboy build
    ;;
  "build-heroku")
    checkLastCommit
    make build-heroku
    ;;
  "release")
    checkLastCommit
    make release
    ;;
  "migrate")
    checkLastCommit
    heroku run rake db:migrate
    ;;
  "populate")
    checkLastCommit
    heroku run rake populate:all
    ;;
  "build-local")
    make PROJECT=paperboy build
    ;;
  *)
    echo Usage:
    echo "$0 build # builds gem"
    echo "$0 push # pushes gem"
    ;;
esac
