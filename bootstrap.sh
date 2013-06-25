#!/bin/bash

# Bootstrap a Ruby on Rails server on Ubuntu 12.10
# Author: Cory Kaufman-Schofield (cory@corykaufman.com)
# 
# This code is meant to be informative and is not written to be fast or
# efficient. Ideally it would be run once to generate a virtual machine image,
# and then servers would be provisioned using the image.

hostname=thorin.townstage.com
ruby_version=2.0.0-p0
chruby_version=0.3.6

# Fail immediately
set -e

# Make sure hostname is set
if ["`cat /etc/hostname`" != "$hostname" ]; then
  echo $hostname > /etc/hostname
  hostname -F /etc/hostname
  # TODO: Add ip address and hostname to /etc/hosts
fi

# Install apt-add-repository so we can add ppas
apt-get -y install software-properties-common

# Chruby
if [ ! -e /usr/local/bin/chruby ]; then
  wget -O /tmp/chruby-$chruby_version.tar.gz https://github.com/postmodern/chruby/archive/v$chruby_version.tar.gz
  tar -xzvf /tmp/chruby-$chruby_version.tar.gz -C /tmp
  (cd /tmp/chruby-$chruby_version && make install)
  rm -rf /tmp/chruby-$chruby_version /tmp/chruby-$chruby_version.tar.gz
fi

# Git
apt-get -y install git-core

# Imagemagick
apt-get -y install imagemagick

# Memcached
apt-get -y install memcached

# Monit
apt-get -y install monit

# Nginx
apt-add-repository -y ppa:nginx/stable
apt-get -y update
apt-get -y install nginx

# Node.js
apt-add-repository -y ppa:chris-lea/node.js
apt-get -y update
apt-get -y install nodejs

# Nokogiri dependencies
apt-get -y install libxslt-dev libxml2-dev

# Postfix
apt-get -y install postfix

# Postgresql 9.2
# -> Ubuntu 12.10 or lower
apt-get -y install libpq-dev
apt-add-repository -y ppa:pitti/postgresql

# -> Ubuntu 13.04 via apt.postgresql.org
# echo "deb http://apt.postgresql.org/pub/repos/apt/ quantal-pgdg main" > /etc/apt/sources.list.d/pgdg.list
# wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -

apt-get -y update
apt-get install postgresql-9.2

# Redis
apt-get -y install redis-server

# Ruby

# -> In order to build ruby, we need a few dependencies:
apt-get -y install build-essential libreadline-dev libssl-dev zlib1g-dev

# -> We only want to install ruby-build if the binary doesn't exist
if [ ! -e /usr/local/bin/ruby-build ]; then
  git clone https://github.com/sstephenson/ruby-build.git /tmp/ruby-build
  (cd /tmp/ruby-build && ./install.sh)
  rm -rf /tmp/ruby-build
fi

if [ ! -d /opt/rubies/ruby-$ruby_version ]; then
  ruby-build $ruby_version /opt/rubies/ruby-$ruby_version
fi

cp home/.gemrc ~/.gemrc

# TODO:
# Create database
# sudo -u postgres psql
# \password
# create user blog with password 'secret';
# create database blog_production owner blog;
# gem install bundler
# apt-get -y install s3cmd

# Cue applause
echo -e "\nBootstrapped!\n"
