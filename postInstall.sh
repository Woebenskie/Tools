#!/bin/bash
echo "dash dash/sh boolean false" | debconf-set-selections
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash 
apt-get update 
apt-get -y upgrade 
apt-get -y install open-vm-tools sudo neovim cockpit lvm2 udisks2-lvm2 udisks2 udisks2-zram tuned bmon mc zip arj ssh-import-id curl ufw lrzsz chrony htop uuid-runtime socat haveged testssl.sh shellcheck lnav 
apt-get install ksmtuned --no-install-recommends 
systemctl stop ksmtuned.service 
systemctl disable ksmtuned.service 
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/g' /etc/default/grub 
update-grub 
echo "gidpro ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/10_gidpro 
runuser -l root -c 'ssh-import-id gh:haringstad' 
runuser -l root -c 'ssh-import-id gh:woebenskie' 
runuser -l gidpro -c 'ssh-import-id gh:haringstad'   
runuser -l gidpro -c 'ssh-import-id gh:woebenskie' 
exit 0
