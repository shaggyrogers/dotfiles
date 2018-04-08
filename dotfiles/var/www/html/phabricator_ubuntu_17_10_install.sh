#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
###############################################################################
# phabricator_install_deps.sh
# ===========================
#
# Description: Install phabricator
#
# Notes
# -----
# Taken from:
# https://secure.phabricator.com/book/phabricator/article/installation_guide/
#
# Modified to work for Ubuntu 17.10
###############################################################################

#!/bin/bash

confirm() {
  echo "Press RETURN to continue, or ^C to cancel.";
  read -e ignored
}

GIT='git'

LTS="Ubuntu 10.04"
ISSUE=`cat /etc/issue`
if [[ $ISSUE != Ubuntu* ]]
then
  echo "This script is intended for use on Ubuntu, but this system appears";
  echo "to be something else. Your results may vary.";
  echo
  confirm
elif [[ `expr match "$ISSUE" "$LTS"` -eq ${#LTS} ]]
then
  GIT='git-core'
fi

echo "PHABRICATOR UBUNTU INSTALL SCRIPT";
echo "This script will install Phabricator and all of its core dependencies.";
echo "Run it from the directory you want to install into.";
echo

ROOT=`pwd`
echo "Phabricator will be installed to: ${ROOT}.";
confirm

echo "Testing sudo..."
sudo true
if [ $? -ne 0 ]
then
  echo "ERROR: You must be able to sudo to run this script.";
  exit 1;
fi;

echo "Installing dependencies: git, apache, mysql, php...";
echo

set +x

# Changed
sudo apt-get -qq update
sudo apt-get install \
  $GIT mysql-server apache2 dpkg-dev \
  php7.1 php7.1-mysql php7.1-gd php7.1-dev php7.1-curl php-apcu php7.1-cli \
  php7.1-json libapache2-mod-php7.1 php-apcu-bc php-common php-pear php-xml \
  php7.1-common php7.1-opcache php7.1-readline php7.1-xml php7.1-mbstring \
  pkg-php-tools shtool apache2-doc

# Enable mod_rewrite
sudo a2enmod rewrite

HAVEPCNTL=`php -r "echo extension_loaded('pcntl');"`
if [ $HAVEPCNTL != "1" ]
then
  echo "Installing pcntl...";
  echo
  apt-get source php7.1
  PHP5=`ls -1F | grep '^php7.1-.*/$'`
  (cd $PHP5/ext/pcntl && phpize && ./configure && make && sudo make install)
else
  echo "pcntl already installed";
fi

if [ ! -e libphutil ]
then
  git clone https://github.com/phacility/libphutil.git
else
  (cd libphutil && git pull --rebase)
fi

if [ ! -e arcanist ]
then
  git clone https://github.com/phacility/arcanist.git
else
  (cd arcanist && git pull --rebase)
fi

if [ ! -e phabricator ]
then
  git clone https://github.com/phacility/phabricator.git
else
  (cd phabricator && git pull --rebase)
fi

echo
echo
echo "Install probably worked mostly correctly. Continue with the 'Configuration Guide':";
echo
echo "    https://secure.phabricator.com/book/phabricator/article/configuration_guide/";
echo
echo "You can delete any php7.1-* stuff that's left over in this directory if you want.";

# vim: set ts=4 sw=4 tw=79 fdm=marker et :
