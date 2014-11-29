#!/bin/bash

# This is used to update the site (hopefully quickly).  Should be run via sudo!

cd /VoteSquared/
git pull origin master
bundle install
service nginx restart