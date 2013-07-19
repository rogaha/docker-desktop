# Changelog

## 0.3.0 (2013-07-18)
 + Funcionality: Allow users to configure the screen resolution 
 + Funcionality: Allow users to create multi-sessions 
 * X Screen: Xpra + Xephyr 
 + X Window Manager: Fluxbox

## 0.2.0 (2013-07-10)
 + Funcionality: Allow user's disconnection and reconnection without disrupting the session and its application's status  
 + Funcionality: Applications are rootless (It appears on your desktop as normal windows managed by your window manager)
 + Funcionality: A new password is generated every time that a new container is created
 * X Screen: Xpra instead of Xephyr 
 - X Window Manager: Remove Fluxbox
 - Applications: Fix the locale warning messages
 - Applications: Fix the error javaldx: Could not find a Java Runtime Environment! from Libreoffice
 + Add a changelog

## 0.1.0 (2013-06-28)
 + Funcionality: Allow users to connect remotely to their virtual desktop running inside a docker container over ssh
 + X Screen: Xephyr
 + X Window Manager: Fluxbox
 + X File Manager: ROX-Filer
 + Applications: Libreoffice, Firefox and xterm
