#!/usr/bin/env bash

set -e

sudo apt-get update


# {{{ docker & compose

sudo apt-get install -y apt-transport-https curl
curl https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add --
echo 'deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable' | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get install docker-ce=17.09.0~ce-0~ubuntu -y
sudo systemctl enable docker

sudo apt-get install python-pip -y
sudo pip install docker-compose
# }}}

# {{{ misc utils

# For dig, etc.
sudo apt-get install -y --no-install-recommends dnsutils

# Needed for netstat, etc.
sudo apt-get install -y --no-install-recommends net-tools

# Packet sniffer for debugging.
sudo apt-get install -y --no-install-recommends tcpflow

# Very usefull for finding issues coming from syscalls
sudo apt-get install -y --no-install-recommends strace

# a better top
sudo apt-get install -y --no-install-recommends htop

# editing tool
sudo apt-get install -y --no-install-recommends vim

# terminal multiplexing
sudo apt-get install -y --no-install-recommends tmux

# email client
sudo apt-get install -y --no-install-recommends swaks

# }}}

# {{{ docker gc

sudo curl -L -o /usr/local/bin/docker-gc \
	https://raw.githubusercontent.com/spotify/docker-gc/bb9580df7205da8498f41a5be05aeaeeff012f54/docker-gc

docker_gc_sha='98ea7fa6630aa2e31d5da58033b07cf09cdbd94b0847c167631e346c1fbc2586'
if [ "$(shasum -a 256 /usr/local/bin/docker-gc | cut -d ' ' -f 1)" != "$docker_gc_sha" ]; then
	echo 'Checksum for docker-gc does not match'
	exit 1
fi

sudo chmod +x /usr/local/bin/docker-gc

sudo tee /etc/cron.hourly/docker-gc <<CRON
#!/usr/bin/env bash
FORCE_IMAGE_REMOVAL=1 MINIMUM_IMAGES_TO_SAVE=10 /usr/local/bin/docker-gc
CRON
sudo chmod +x /etc/cron.hourly/docker-gc
# }}}


# {{{ netdata (metrics)
git clone https://github.com/firehol/netdata /tmp/netdata
cd /tmp/netdata
sudo apt-get -y install zlib1g-dev uuid-dev libmnl-dev gcc make curl git autoconf autogen automake pkg-config netcat-openbsd jq
sudo ./netdata-installer.sh --dont-wait --dont-start-it
sudo apt-get purge -y zlib1g-dev uuid-dev libmnl-dev gcc make autoconf autogen automake pkg-config
cd /
rm -rf /tmp/netdata
mv /tmp/netdata.service /etc/systemd/system/netdata.service
chmod +x /usr/sbin/private-if
sudo systemctl enable netdata
# }}}

