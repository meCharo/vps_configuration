#################################
#########preparation#############
#################################
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
your_name="v2ray2"
if [ $your_name == "shadowsocks" ];then
  echo "shadowsocks"
elif [ $your_name == "v2ray" ];then
  echo "v2ray"
else
  echo $your_name
  exit 1
fi
#---------shadowsocks------------
if $[your_name] -eq "shadowsocks";then
  pip3 install shadowsocks
  echo -e "{\"server\": \"0.0.0.0\",
    \"server_port\": 25000,
    \"password\": \"changhao\",
    \"method\": \"aes-256-cfb\"
  }" > /etc/shadowsocks.json
  echo -e "[Unit]
  Description=Shadowsocks

  [Service]
  TimeoutStartSec=0
  ExecStart=/usr/local/bin/ssserver -c /etc/shadowsocks.json

  [Install]
  WantedBy=multi-user.target" > /etc/systemd/system/shadowsocks.service
  systemctl enable shadowsocks
  systemctl start shadowsocks
else
#------------V2Ray---------------
  curl -Ls https://install.direct/go.sh | sudo bash
  rm -f go.sh
  wget https://raw.githubusercontent.com/meCharo/vps_configuration/master/config.json -O /etc/v2ray/config.json
  systemctl enable v2ray
  systemctl start v2ray
fi

#################################
########download tools###########
#################################
#---------youtube-dl-------------
wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl
#------------yasm----------------
mkdir /root/temp && cd /root/temp
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
wget -O gdrive https://sites.google.com/site/wun913/Home/gdrive-linux-x64
mv gdrive /usr/bin/gdrive
chmod +x /usr/bin/gdrive
# Usage: https://github.com/gdrive-org/gdrive
# Usage: gdrive about->gdrive list->gdrive download ..

#################################
###########upload tools##########
#################################
#------------BaiduPCS------------
cd /root/temp
wget https://github.com/iikira/BaiduPCS-Go/releases/download/v3.6/BaiduPCS-Go-v3.6-linux-amd64.zip
unzip BaiduPCS-Go-v3.6-linux-amd64.zip
mv BaiduPCS-Go-v3.6-linux-amd64 /usr/local/bin/BaiduPCS-Go_bin
chmod a+rx /usr/local/bin/BaiduPCS-Go_bin
ln -s /usr/local/bin/BaiduPCS-Go_bin/BaiduPCS-Go /usr/local/bin/BaiduPCS-Go
cd /root/temp && rm -f BaiduPCS-Go-v3.6-linux-amd64.zip
# Usage: BaiduPCS-Go login->BaiduPCS-Go u->BaiduPCS-Go download

# post-installation
cd /root && rm -rf temp && rm -f vps_installation.sh

