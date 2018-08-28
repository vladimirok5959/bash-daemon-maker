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
```
Check for dependences...
Check directories...
Download latest empty daemon...
Installing...
Create symlink...
Create config file for logrotate...
Done! Daemon with name 'my-service' successfully generated!
```
cd ~; rm -rd ~/tmpdaemon  
  
Now we can simply edit `/etc/my-service/scripts/example.sh` file or create another one file in `/etc/my-service/scripts` folder and write our logic.  
  
**Auto assembly created for and works only on Linux Debian.**
