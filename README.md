# bash-daemon-maker
Daemon auto assembly by make utility for [bash-empty-daemon](https://github.com/vladimirok5959/bash-empty-daemon)

## Dependences
```
apt-get install make
apt-get install wget
apt-get install unzip
```
And root access.

## How to use
su root  
apt-get install make; apt-get install wget; apt-get install unzip; mkdir ~/tmpdaemon; cd ~/tmpdaemon; wget -O Makefile https://github.com/vladimirok5959/bash-daemon-maker/releases/download/latest/Makefile; make  
make install NAME=**my-service**  
cd ~; rm -rd ~/tmpdaemon  
  
Now we can simply edit daemon `/etc/my-service/loop.sh` file for our logic.  
  
**Auto assembly created for and works only on Linux Debian.**  
**For MAX OS X you will needs to change vars `BINDIR`, `LROTDIR` and `INSTALLDIR` to new location.**
