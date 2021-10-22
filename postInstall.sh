#!/bin/bash
mkdir /home/gidpro/A
dpkg-reconfigure dash 
touch /home/gidpro/A/1
apt-get update 
touch /home/gidpro/A/2
apt-get -y upgrade 
touch /home/gidpro/A/3
apt-get -y install open-vm-tools sudo neovim cockpit lvm2 udisks2-lvm2 udisks2 udisks2-zram tuned bmon mc zip arj ssh-import-id curl ufw lrzsz chrony htop uuid-runtime socat haveged testssl.sh shellcheck lnav 
touch /home/gidpro/A/4
apt-get install ksmtuned --no-install-recommends 
touch /home/gidpro/A/5
systemctl stop ksmtuned.service 
touch /home/gidpro/A/6
systemctl disable ksmtuned.service 
touch /home/gidpro/A/7
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/g' /etc/default/grub 
touch /home/gidpro/A/8
update-grub 
touch /home/gidpro/A/9
echo "gidpro ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/10_gidpro 
touch /home/gidpro/A/10
ssh-import-id gh:haringstad 
touch /home/gidpro/A/11
ssh-import-id gh:woebenskie 
touch /home/gidpro/A/12
runuser -l gidpro -c 'ssh-import-id gh:haringstad'   
touch /home/gidpro/A/13
runuser -l gidpro -c 'ssh-import-id gh:woebenskie' 
touch /home/gidpro/A/14
