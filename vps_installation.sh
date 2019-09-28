# preparation
yum update -y
yum install wget gcc gcc-c++ make unzip -y

# shadowsocks
## python
cd /root && mkdir temp && cd /root/temp
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
python get-pip.py
## shadowsocks
pip install shadowsocks
echo -e "{\"server\": \"0.0.0.0\",
  \"server_port\": 25000,
  \"password\": \"changhao\",
  \"method\": \"aes-256-cfb\"
}" > /etc/shadowsocks.json
echo -e "[Unit]
Description=Shadowsocks

[Service]
TimeoutStartSec=0
ExecStart=/usr/bin/ssserver -c /etc/shadowsocks.json

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/shadowsocks.service
## firework and enable startup
firewall-cmd --permanent --add-port=25000/tcp # only centos7
firewall-cmd --reload # reload after modify
# iptables -A INPUT -p tcp --dport 1024 -j ACCEPT # only centos6
# systemctl stop firewalld
# systemctl disable firewalld
systemctl start shadowsocks
systemctl enable shadowsocks


# download tools: youtube-dl
## youtube-dl
wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl
## yasm
cd /root/temp
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar -zxvf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure
make
make install
cd /root/temp && rm -rf yasm-1.3.0 && rm -rf yasm-1.3.0.tar.gz
## ffmpeg
cd /root/temp
wget http://www.ffmpeg.org/releases/ffmpeg-3.3.3.tar.gz
tar -zxvf ffmpeg-3.3.3.tar.gz
cd ffmpeg-3.3.3
./configure
make
make install
cd /root/temp && rm -rf ffmpeg-3.3.3 && rm -rf ffmpeg-3.3.3.tar.gz


# upload tools: BaiduPCS
cd /root/temp
wget https://github.com/iikira/BaiduPCS-Go/releases/download/v3.6/BaiduPCS-Go-v3.6-linux-amd64.zip
unzip BaiduPCS-Go-v3.6-linux-amd64.zip
mv BaiduPCS-Go-v3.6-linux-amd64.zip /usr/local/bin/BaiduPCS-Go_bin
chmod a+rx /usr/local/bin/BaiduPCS-Go_bin
ln -s /usr/local/bin/BaiduPCS-Go_bin/BaiduPCS-Go /usr/local/bin/BaiduPCS-Go
cd /root/temp && rm -f BaiduPCS-Go-v3.6-linux-amd64.zip
# BaiduPCS-Go u ... /hypnosis_download


# post-installation
cd /root && rm -rf temp && rm -f vps_installation.sh

