#!/bin/sh

usage() {
  echo "USAGE: sh reinstall-django.sh [Package-Manager] [Pip-pkg] [NodeJs-pkg] [Yarn-pkg]"
  echo "If no paramters provided, runs with variables defined in script. All or no paramters"
}

if [ $# -lt 4 ] && [ $# -gt 0 ] 
then
  usage && exit 
fi

_INSTALLER="sudo xbps-install -S"
_PIP_PKG="python3-pip"
_NPM_PKG="nodejs nodejs-devel"
_YARN_PKG="yarn"

$_INSTALLER $_PIP_PKG
pip install pipenv || ( echo "Failed to install pipenv" && exit )
[-z ~/.local/bin/] && ~/.local/bin/pipenv shell && pipenv install django djangorestframework django-cors-headers

$_INSTALLER $_NPM_PKG || (echo "Failed to install nodejs" && exit )
type npm && sudo npm install -g create-react-app

$_INSTALLER $_YARN_PKG
type yarn && yarn add axios bootstrap reactstrap 
