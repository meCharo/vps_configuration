#!/bin/sh

#################################
#########preparation#############
#################################
mkdir /root/temp && cd /root/temp
yum update -y
#-----------system---------------
yum install -y zip unzip wget
echo "export LC_ALL=en_US.UTF-8" >> $HOME/.bashrc
echo "export LANG=en_US.UTF-8" >> $HOME/.bashrc

#----------firework--------------
# firewall-cmd --permanent --add-port=25000/tcp # only centos7
# firewall-cmd --reload # reload after modify
# iptables -A INPUT -p tcp --dport 25000 -j ACCEPT # only centos6
# chkconfig iptables off
systemctl stop firewalld
systemctl disable firewalld


#################################
########### python ##############
#################################
cd /root/temp
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O Miniconda3.sh
bash Miniconda3.sh -b -p $HOME/Applications/miniconda
source $HOME/Applications/miniconda/bin/activate
conda init
source ~/.bashrc
conda create -n py python=3.6 -y
conda activate py
cd /root/temp && rm -rf Miniconda3.sh


#################################
#############proxy###############
#################################
your_name="v2ray"
#---------shadowsocks------------
if [ $your_name == "shadowsocks" ];then
  pip3 install shadowsocks
  wget https://raw.githubusercontent.com/meCharo/vps_configuration/master/shadowsocks/shadowsocks.json -O /etc/shadowsocks.json
  wget https://raw.githubusercontent.com/meCharo/vps_configuration/master/shadowsocks/shadowsocks.service -O /etc/systemd/system/shadowsocks.service
  systemctl enable shadowsocks
  systemctl start shadowsocks
#------------V2Ray---------------
elif [ $your_name == "v2ray" ];then
#   curl -Ls https://install.direct/go.sh | sudo bash
  curl -O https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh
  bash install-release.sh
  rm -f install-release.sh
#   wget https://raw.githubusercontent.com/meCharo/vps_configuration/master/v2ray/config.json -O /etc/v2ray/config.json
  wget https://raw.githubusercontent.com/meCharo/vps_configuration/master/v2ray/config.json -O /usr/local/etc/v2ray/config.json
  systemctl enable v2ray
  systemctl start v2ray
else
  echo $your_name
  exit 1
fi


#################################
########download tools###########
#################################
#---------youtube-dl-------------
conda install ffmpeg -y
pip install youtube-dl
mkdir $HOME/.config/youtube-dl
wget https://raw.githubusercontent.com/meCharo/vps_configuration/master/youtube-dl/config -O $HOME/.config/youtube-dl/config


#################################
########transfer tools###########
#################################
yum -y install vsftpd
systemctl start vsftpd.service


#################################
#######post-installation#########
#################################
cd /root && rm -rf temp && rm -f create_vps.sh

