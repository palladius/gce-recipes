#!/bin/bash

VER=1.1

#################################
## KUBERNIZER
#################################

touch /root/00-start.touch

echo deb http://http.debian.net/debian wheezy-backports main > /etc/apt/sources.list.d/docker.list

apt-get update
apt-get install -y git bash-completion make

touch /root/01-apt-installed-ok.touch

### Install docker
# for docker
apt-get install -ty wheezy-backports linux-image-amd64
# on debian: https://docs.docker.com/installation/debian/#debian-wheezy-7-64-bit
curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker ricc

touch /root/02-docker-ok.touch

mkdir -p /opt

# for kubernetes-0.5 try this:
# https://github.com/GoogleCloudPlatform/kubernetes/blob/master/docs/getting-started-guides/aws.md

git clone https://github.com/GoogleCloudPlatform/kubernetes.git /opt/kubernetes &&
	cd /opt/kubernetes &&
		yes | make release &&
			touch /root/03-kubernetes-latest.touch

(
echo "# Added by kubernetes-latest startup script on $(date):"
echo "export PATH=$PATH:/opt/kubernetes/_output/local/bin/linux/amd64/:/opt/kubernetes/_output/release-stage/server/linux-amd64/kubernetes/server/bin/"
)>> .bashrc

cd /opt/kubernetes &&
	hack/dev-build-and-up.sh &&
		touch /root/04-kubernetes-deb-build-and-up-correctly.touch

/usr/local/bin/gcloud components update -q

