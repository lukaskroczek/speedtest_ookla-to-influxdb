#!/bin/sh

printenv >> /etc/environment
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install speedtest-cli
if [ ! -e /usr/bin/speedtest ]
then
  curl -L "https://packagecloud.io/ookla/speedtest-cli/gpgkey" 2> /dev/null | apt-key add -
  #echo "deb https://packagecloud.io/ookla/speedtest-cli/debian/ buster main" | tee  /etc/apt/sources.list.d/ookla_speedtest-cli.list
  curl -s https://install.speedtest.net/app/cli/install.deb.sh 2> /dev/null | bash
  apt-get update && apt-get -q -y install speedtest
  apt-get -q -y autoremove && apt-get -q -y clean
  rm -rf /var/lib/apt/lists/*
fi

exec /usr/local/bin/python3 $@
