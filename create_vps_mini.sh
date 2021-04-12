#!/bin/sh

# wget https://raw.githubusercontent.com/meCharo/vps_configuration/master/create_vps_mini.sh
# bash create_vps_mini.sh


#################################
#########preparation#############
#################################
mkdir /root/temp && cd /root/temp
yum update -y
#-----------system---------------
yum install -y zip unzip wget git
echo "export LC_ALL=en_US.UTF-8" >> $HOME/.bashrc
echo "export LANG=en_US.UTF-8" >> $HOME/.bashrc
echo "alias zip='zip -q -r'" >> $HOME/.bashrc

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
# cd /root/temp
# wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O Miniconda3.sh
# bash Miniconda3.sh -b -p $HOME/Applications/miniconda
# source $HOME/Applications/miniconda/bin/activate
# conda init
# source ~/.bashrc
# conda create -n py python=3.6 -y
# conda activate py
# cd /root/temp && rm -rf Miniconda3.sh


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
  wget https://github.com/meCharo/vps_configuration/releases/download/v4.23.3/v2ray-linux-64.zip
  unzip -d $HOME/Applications/v2ray v2ray-linux-64.zip
  chmod -R 777 $HOME/Applications/v2ray
  wget https://raw.githubusercontent.com/meCharo/vps_configuration/master/v2ray/config.json -O $HOME/Applications/v2ray/myconfig.json
#   systemctl enable v2ray
#   systemctl start v2ray
  screen -dmS v2ray /root/Applications/v2ray/v2ray -config /root/Applications/v2ray/myconfig.json
else
  echo $your_name
  exit 1
fi



#################################
#######post-installation#########
#################################
cd /root && rm -rf temp && rm -f create_vps_mini.sh
# echo "conda activate py" >> $HOME/.bashrc
