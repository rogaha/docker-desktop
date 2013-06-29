# This file creates a container that runs X11 and SSH services
# The ssh is used to forward X11 and provide you encrypted data
# communication between the docker container and your local 
# machine.
#
# Xephyr allows to display the programs running inside of the
# container such as Firefox, LibreOffice, xterm, etc. 
#
# Fluxbox and ROX-Filer creates a very minimalist way to 
# manages the windows and files.


FROM ubuntu:12.10
MAINTAINER Roberto G. Hashioka "roberto_hashioka@hotmail.com"

RUN apt-get update

# Set the env variable DEBIAN_FRONTEND to noninteractive
RUN export DEBIAN_FRONTEND=noninteractive

# Installing the environment required: xserver, xdm, flux box, roc-filer and ssh
RUN apt-get install -y xserver-xephyr xdm fluxbox rox-filer ssh 

# Configuring xdm to allow connections from any IP address and ssh to allow X11 Forwarding. 
RUN sed -i 's/DisplayManager.requestPort/!DisplayManager.requestPort/g' /etc/X11/xdm/xdm-config
RUN sed -i '/#any host/c\*' /etc/X11/xdm/Xaccess
RUN echo X11Forwarding yes >> /etc/ssh/ssh_config

# Add an user called docker and set its password as docker
RUN useradd -m -d /home/docker -p aaOLN9pfuDGV. docker
RUN sed -Ei 's/adm:x:4:/docker:x:4:docker/' /etc/group

# Set the default shell as bash for docker user
RUN chsh -s /bin/bash docker

# Upstart and DBus have issues inside docker. We work around in order to install firefox.
RUN dpkg-divert --local --rename --add /sbin/initctl && ln -s /bin/true /sbin/initctl

# Installing the apps: Firefox, flash player plugin, LibreOffice and xterm
RUN apt-get install -y firefox libreoffice-gtk libreoffice-calc xterm ubuntu-restricted-extras

# Copy the files into the container
ADD . /src
RUN cd /src; tar -C /home/docker -xvf config.tar; chown -R docker:docker /home/docker/*

EXPOSE 22
# Start xdm and ssh services.
CMD ["/bin/bash", "/src/startup.sh"]
