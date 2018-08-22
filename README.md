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
apt-get install make; apt-get install wget; apt-get install unzip; mkdir ~/tmpdaemon; cd ~/tmpdaemon; wget -O Makefile https://raw.githubusercontent.com/vladimirok5959/bash-daemon-maker/master/Makefile; make<br>
make install NAME=**my-service**<br>
cd ~; rm -rd ~/tmpdaemon<br>
<br>
Now we can simply edit daemon `loop.sh` file for our logic.
