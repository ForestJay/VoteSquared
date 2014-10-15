#!/bin/bash

# This is used to update the site (hopefully quickly).  Should be run via sudo!

$USER="$(id -u)"

if [[ $USER == "root" ]] ; then
  echo "Don't run this as root!"
  exit 1
fi

cd /VoteSquared/
git pull origin master
bundle install
service nginx restart