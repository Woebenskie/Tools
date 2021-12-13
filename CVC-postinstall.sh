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
systemctl disable wpa_supplicant
apt autoremove
apt autoclean
apt clean
####################################################
# CVC Custom
####################################################
apt update -y && apt upgrade -y
apt install lighttpd vim nano openssl -y
mkdir -p /etc/lighttpd/certs
mkdir -p /etc/lighttpd/vhosts.d
openssl req -new -x509 -sha256 -newkey rsa:2048 -nodes -subj '/CN=localhost' -keyout /etc/lighttpd/certs/start.key.pem -days 1460 -out /etc/lighttpd/certs/start.cert.pem
echo "server.modules += (\"mod_openssl\")" > /etc/lighttpd/vhosts.d/all-vhosts-ssl.conf
echo "\$SERVER[\"socket\"] == \":443\" {" >> /etc/lighttpd/vhosts.d/all-vhosts-ssl.conf
echo "    ssl.engine=\"enable\" " >> /etc/lighttpd/vhosts.d/all-vhosts-ssl.conf
echo "    ssl.pemfile=\"/etc/lighttpd/certs/start.cert.pem\" " >> /etc/lighttpd/vhosts.d/all-vhosts-ssl.conf
echo "    ssl.privkey=\"/etc/lighttpd/certs/start.key.pem\" " >> /etc/lighttpd/vhosts.d/all-vhosts-ssl.conf
echo "}" >> /etc/lighttpd/vhosts.d/all-vhosts-ssl.conf
systemctl enable lighttpd

mkdir -p /var/www/html/localhost
chmod -R 755 /var/www/html/localhost
echo "<html><body>welcome to localhost</body></html>" > /var/www/html/localhost/index.html
chown -R lighttpd:lighttpd /var/www/html/localhost
cp /etc/lighttpd/lighttpd.conf /etc/lighttpd/lighttpd-conf.orig
cp /root/lighttpd.conf /etc/lighttpd/lighttpd.conf

# simple lightpd check: Syntax must be OK
$( which lighttpd ) -t -f /etc/lighttpd/lighttpd.conf

systemctl start lighttpd


exit 0
