#!/bin/sh

mkdir /root/temp && cd /root/temp
yum update -y

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
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O Miniconda3.sh
bash Miniconda3.sh -b -p $HOME/Applications/miniconda












source ~/.bashrc
conda create -n py python=3.6 -y
conda activate py
conda install ffmpeg -y
pip install youtube-dl
