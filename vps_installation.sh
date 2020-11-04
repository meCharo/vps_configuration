#################################
#########preparation#############
#################################
mkdir /root/temp && cd /root/temp
yum update -y
yum install wget gcc gcc-c++ make unzip python36 -y
#----------firework--------------
# firewall-cmd --permanent --add-port=25000/tcp # only centos7
# firewall-cmd --reload # reload after modify
# iptables -A INPUT -p tcp --dport 25000 -j ACCEPT # only centos6
# chkconfig iptables off
# systemctl stop firewalld
# systemctl disable firewalld

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
wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl
#------------yasm----------------
cd /root/temp
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar -zxvf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure
make
make install
cd /root/temp && rm -rf yasm-1.3.0 && rm -rf yasm-1.3.0.tar.gz
#------------ffmpeg--------------
cd /root/temp
wget http://www.ffmpeg.org/releases/ffmpeg-3.3.3.tar.gz
tar -zxvf ffmpeg-3.3.3.tar.gz
cd ffmpeg-3.3.3
./configure
make
make install
cd /root/temp && rm -rf ffmpeg-3.3.3 && rm -rf ffmpeg-3.3.3.tar.gz
#------------gdrive--------------
# wget -O gdrive https://sites.google.com/site/wun913/Home/gdrive-linux-x64
# mv gdrive /usr/bin/gdrive
# chmod +x /usr/bin/gdrive
# Usage: https://github.com/gdrive-org/gdrive
# Usage: gdrive about->gdrive list->gdrive download ..

#################################
###########upload tools##########
#################################
#------------BaiduPCS------------
# cd /root/temp
# wget https://github.com/iikira/BaiduPCS-Go/releases/download/v3.6/BaiduPCS-Go-v3.6-linux-amd64.zip
# unzip BaiduPCS-Go-v3.6-linux-amd64.zip
# mv BaiduPCS-Go-v3.6-linux-amd64 /usr/local/bin/BaiduPCS-Go_bin
# chmod a+rx /usr/local/bin/BaiduPCS-Go_bin
# ln -s /usr/local/bin/BaiduPCS-Go_bin/BaiduPCS-Go /usr/local/bin/BaiduPCS-Go
# cd /root/temp && rm -f BaiduPCS-Go-v3.6-linux-amd64.zip
# Usage: BaiduPCS-Go login->BaiduPCS-Go u->BaiduPCS-Go download

# post-installation
cd /root && rm -rf temp && rm -f vps_installation.sh

