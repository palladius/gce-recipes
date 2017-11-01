#!/bin/bash

VER=1.0

# for kubernetes-0.5 try this:
# https://github.com/GoogleCloudPlatform/kubernetes/blob/master/docs/getting-started-guides/aws.md
_install_kubernetes_05() {
	cd /opt
	wget https://github.com/GoogleCloudPlatform/kubernetes/releases/download/v0.5/kubernetes.tar.gz
	tar -xzf kubernetes.tar.gz; cd kubernetes
	
	(
	echo "# Added by kubernetes startup script on $(date):"
	echo "export PATH=$PATH:/opt/kubernetes/platforms/linux/amd64/" 
	)>> /root/.bashrc

	# git clone https://github.com/GoogleCloudPlatform/kubernetes.git /opt/kubernetes &&
	# 	cd /opt/kubernetes &&
	# 		yes | make release &&
	# 			touch /root/03-kubernetes-latest.touch

	cd /opt/kubernetes &&
		cluster/kube-up.sh &&
			touch /root/05-kube-v0.5.mas-o-menos.touch

	touch /root/04-cluster-kube-up.OK.touch
}

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



_install_kubernetes_05

/usr/local/bin/gcloud components update -q

