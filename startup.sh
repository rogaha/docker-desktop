#!/bin/bash

# Create the directory needed to run the sshd daemon
mkdir /var/run/sshd 

# restarts the xdm service
/etc/init.d/xdm restart

# starts the ssh service
/usr/sbin/sshd -D

