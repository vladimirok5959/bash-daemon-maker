# bash-daemon-maker
Daemon auto assembly by make utility

## Dependences
```
apt-get install make
apt-get install wget
apt-get install unzip
```
And root access.

## How to use
su root<br>
apt-get install make; apt-get install wget; apt-get install unzip; mkdir ~/tmpdaemon; cd ~/tmpdaemon; wget -O Makefile https://github.com/vladimirok5959/bash-daemon-maker/releases/download/latest/Makefile; make<br>
make install NAME=**my-service**<br>
cd ~; rm -rd ~/tmpdaemon<br>
<br>
Now we can simply edit daemon `loop.sh` file for our logic.<br>
<br>
**Auto assembly created for and works only on Linux Debian.**<br>
**For MAX OS X you will needs to change vars `BINDIR`, `LROTDIR` and `INSTALLDIR` to new location.**
