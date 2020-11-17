# Overview
You can use this script to configurate your vps easily by run 
`wget https://raw.githubusercontent.com/meCharo/vps_configuration/master/create_vps.sh && bash create_vps.sh && source $HOME/.bashrc`.
# System version
Centos 7.2, which just influence the part of preparation, like `yum update` and so on.
# Content
1. shadowsocks/v2ray
3. youtube-dl
4. ffmpeg
5. gdrive
6. BaiduPCS
# Advise
Use the the screen to run the script as following:
``` bash
yum install screen wget -y
echo -e "defutf8 on\ndefencoding utf8\nencoding UTF-8 UTF-8" > ~/.screenrc
wget https://raw.githubusercontent.com/meCharo/vps_configuration/master/create_vps.sh
screen -S install bash create_vps.sh
```
