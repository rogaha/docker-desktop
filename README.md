DOCKER-DESKTOP
==============

##Description

This Dockerfile creates a container that runs X11 and SSH services.
The ssh is used to forward X11 and provide you encrypted data
communication between the docker container and your local 
machine.

Xephyr allows to display the programs running inside of the
container such as Firefox, LibreOffice, xterm, etc. 

Fluxbox and ROX-Filer creates a very minimalist way to 
manages the windows and files.

OBS: The client machine needs to have a X11 server installed. See the "Notes" below. 

![Docker L](image/docker-desktop.png "Docker-Desktop")

##Installation


###Building the docker image

```
$ docker build -t [username]/docker-desktop git://github.com/rogaha/docker-desktop.git
```

###Running the docker image created (-d: detached mode)

```
$ CONTAINER_ID=$(docker run -d robertohashioka/docker-xephry-ssh-v2)
```

###Getting the external ssh port of the new running container 

```
$ docker port $CONTAINER_ID 22
49153 # This is the external port that forwards to the ssh service running inside of the container as port 22
```

##Usage

###Connecting to the container 

```
$ ifconfig | grep "inet addr:" 
inet addr:192.168.56.102  Bcast:192.168.56.255  Mask:255.255.255.0 # This is the LAN's IP for this machine

$ ssh -YC -c blowfish docker@192.168.56.102 -p 49153 # Here is where we use the external port
docker@192.168.56.102's password: docker # The Desktop should open up automatically after you type the password
```

##Notes

###On Windows:
Requirements:
- Xming (http://sourceforge.net/project/downloading.php?group_id=156984&filename=Xming-6-9-0-31-setup.exe)
- Putty (http://the.earth.li/~sgtatham/putty/latest/x86/putty.exe)
- Configuration Tutorial (https://wiki.utdallas.edu/wiki/display/FAQ/X11+Forwarding+using+Xming+and+PuTTY)
	- Set the X Display location as localhost:10
	- Starts the Xming using the display number as 10

###On OS X:
Requirements:
- XQuartz (http://xquartz.macosforge.org/downloads/SL/XQuartz-2.7.4.dmg)

OBS: Currently there is a bug on XQuartz. The keyboard gets messed up when Xephyr tries to configure the X11 server's keyboard.

###On Linux:
There is no requiment. If you have a Linux Desktop you should have X11 server installed already.