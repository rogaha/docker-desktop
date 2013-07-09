DOCKER-DESKTOP
==============

##Next Version Coming Soon

1) Xpra (http://en.wikipedia.org/wiki/Xpra) instead of Xephyr+fluxbox. It will allow disconnection and reconnection without disrupting the forwarded application, self-tuning and latency-insensitive.

2) The password will be generated during runtime using PWGen (http://sourceforge.net/p/pwgen-win/wiki/Home/). It's a password generator capable of creating large amounts of cryptographically-secure passwords.

##Description

This Dockerfile creates a docker image and once it's executed it creates a container that runs X11 and SSH services.
The ssh is used to forward X11 and provide you encrypted data
communication between the docker container and your local 
machine.

Xephyr allows to display the programs running inside of the
container such as Firefox, LibreOffice, xterm, etc. 

Fluxbox and ROX-Filer creates a very minimalist way to 
manages the windows and files.

![Docker L](image/docker-desktop.png "Docker-Desktop")

OBS: The client machine needs to have a X11 server installed. See the "Notes" below. 

##Installation


###Building the docker image

```
$ docker build -t [username]/docker-desktop git://github.com/rogaha/docker-desktop.git
```

###Running the docker image created (-d: detached mode)

```
$ CONTAINER_ID=$(docker run -d [username]/docker-desktop)
```

###Getting the container's external ssh port 

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

-Y = Trusted X11 Forwarding
-C = Use compression 
-c blowfish = It should be the fastest compression type
```

##Notes

###On Windows:
Requirements:
- Xming (http://sourceforge.net/projects/xming/)
- Putty (http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html)
- Configuration Tutorial (https://wiki.utdallas.edu/wiki/display/FAQ/X11+Forwarding+using+Xming+and+PuTTY)

###On OS X:
Requirements:
- XQuartz (http://xquartz.macosforge.org/landing/)

OBS: Currently there is a bug on XQuartz. The keyboard gets messed up when Xephyr tries to configure the X11-server's keyboard.

###On Linux:
There is no requiment. If you have a Linux Desktop you should have X11 server installed already.
