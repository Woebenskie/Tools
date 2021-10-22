#!/bin/bash
####################################################
# Make Bash default shell
####################################################
echo "dash dash/sh boolean false" | debconf-set-selections
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

####################################################
# Upgrade all packages and upgrade
####################################################
apt-get update 
apt-get -y upgrade 

####################################################
# Install default tools
####################################################
apt-get -y install open-vm-tools sudo neovim cockpit lvm2 udisks2-lvm2 udisks2 udisks2-zram tuned bmon mc zip arj ssh-import-id curl ufw lrzsz chrony htop uuid-runtime socat haveged testssl.sh shellcheck lnav levee

####################################################
# Install Memory Management tools
####################################################
apt-get install ksmtuned --no-install-recommends 
systemctl stop ksmtuned.service 
systemctl disable ksmtuned.service 

####################################################
# Use "eth0", "eth1" names for network devices
####################################################
echo "COMPRESS=xz" > /etc/initramfs-tools/conf.d/compress
update-initramfs -u
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/g' /etc/default/grub 
update-grub 

####################################################
# Do the user magic stuff
####################################################
echo "gidpro ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/10_gidpro 
runuser -l root -c 'ssh-import-id gh:haringstad' 
runuser -l root -c 'ssh-import-id gh:woebenskie' 
runuser -l gidpro -c 'ssh-import-id gh:haringstad'   
runuser -l gidpro -c 'ssh-import-id gh:woebenskie' 

####################################################
# cleanup
####################################################
apt remove -y debian-faq debian-faq-de debian-faq-fr debian-faq-it debian-faq-zh-cn doc-debian eject foomatic-filters laptop-detect
systemctl disable ModemManager
systemctl disable wpa-supplicant
apt autoremove
apt autoclean
apt clean
####################################################
# End of the script
####################################################

exit 0
