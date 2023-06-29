#!/bin/sh

printenv >> /etc/environment
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install speedtest-cli
if [ ! -e /usr/bin/speedtest ]
then
  mkdir -p /etc/apt/keyrings
  chmod 755 /etc/apt/keyrings
  curl -fsSL https://packagecloud.io/ookla/speedtest-cli/gpgkey | gpg --dearmor > /etc/apt/keyrings/ookla_speedtest-cli-archive-keyring.gpg
  
  curl -s https://install.speedtest.net/app/cli/install.deb.sh 2> /dev/null | bash
  apt-get update && apt-get -q -y install speedtest
  apt-get -q -y autoremove && apt-get -q -y clean
  rm -rf /var/lib/apt/lists/*
fi

exec /usr/local/bin/python3 $@
