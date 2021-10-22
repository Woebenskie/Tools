# Tools
This repo is used to fast install new systems with debian preseed

Use with care!

## VM setup
To use this, create a new VM with the following (minimum) specifications:
* 2 CPU
* 4 GB RAM
* 32 GB (Thin Provisioned) Disk
* 1 ethernet device
## Network Setup
To make this almost fully automagic, do the following after creating the VM:
* Add the MAC address of the VM to the DHCP server
* Make DNS entries for this host, so the installer will automagically use these names
## Finally
Boot the VM, PXE and you should be able to install your server automagically with the default toolsetting, and a default partition set.


