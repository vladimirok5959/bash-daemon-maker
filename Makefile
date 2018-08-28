RELEASEURL:="https://github.com/vladimirok5959/bash-empty-daemon/releases/download/latest/daemon.zip"
BINDIR:=/usr/local/bin
LROTDIR:=/etc/logrotate.d
INITD:=/etc/init.d
INSTALLDIR:=/etc
SINITED:="0"

default: check info

install: check dir-test download create-link create-logrotate create-autostart show-done-msg

check:
	$(eval SINITED="1")
	@echo "Check for dependences..."
	@wget -V > /dev/null
	@unzip -v > /dev/null

dir-test: check-manual-run check-if-name-set
	@echo "Check directories..."
	@if [ ! -d "$(BINDIR)" ]; then \
		echo "Aborted. Dir '$(BINDIR)' is not exists"; \
		exit 1; \
	fi
	@if [ ! -d "$(LROTDIR)" ]; then \
		echo "Aborted. Dir '$(LROTDIR)' is not exists"; \
		exit 1; \
	fi
	@if [ ! -d "$(INSTALLDIR)" ]; then \
		echo "Aborted. Dir '$(INSTALLDIR)' is not exists"; \
		exit 1; \
	fi
	@if [ -d "$(INSTALLDIR)/$(NAME)" ]; then \
		echo "Aborted. Directory '$(INSTALLDIR)/$(NAME)' already exists"; \
		exit 1; \
	fi

info: check-manual-run
	@echo "You can run 'make install NAME=my-service'"

download: check-manual-run check-if-name-set
	@if [ ! -z "$(NAME)" ]; then \
		echo "Download latest empty daemon..."; \
		cd $(INSTALLDIR); \
		mkdir $(NAME); \
		cd $(NAME); \
		wget -q $(RELEASEURL) > /dev/null; \
		echo "Installing..."; \
		unzip -o daemon.zip > /dev/null; \
		rm daemon.zip; \
		mv run.sh $(NAME).sh; \
		chmod 744 $(NAME).sh; \
	fi

create-link: check-manual-run check-if-name-set
	@if [ ! -z "$(NAME)" ]; then \
		echo "Create symlink..."; \
		ln -sf $(INSTALLDIR)/$(NAME)/$(NAME).sh $(BINDIR)/$(NAME); \
	fi

create-logrotate: check-manual-run check-if-name-set
	@if [ ! -z "$(NAME)" ]; then \
		echo "Create config file for logrotate..."; \
		echo "$(INSTALLDIR)/$(NAME)/logs/all.log {" > $(LROTDIR)/$(NAME); \
		echo "	daily" >> $(LROTDIR)/$(NAME); \
		echo "	missingok" >> $(LROTDIR)/$(NAME); \
		echo "	rotate 14" >> $(LROTDIR)/$(NAME); \
		echo "	compress" >> $(LROTDIR)/$(NAME); \
		echo "	delaycompress" >> $(LROTDIR)/$(NAME); \
		echo "	notifempty" >> $(LROTDIR)/$(NAME); \
		echo "	create 640 root root" >> $(LROTDIR)/$(NAME); \
		echo "	sharedscripts" >> $(LROTDIR)/$(NAME); \
		echo "}" >> $(LROTDIR)/$(NAME); \
	fi

create-autostart:
	@if [ ! -z "$(NAME)" ]; then \
		echo "Create auto start script..."
		if [ ! -d "$(INITD)" ]; then \
			echo "Aborted. Dir '$(INITD)' is not exists"; \
			exit 1; \
		fi; \
		echo "#!/bin/sh" > $(INITD)/$(NAME); \
		echo "" >> $(INITD)/$(NAME); \
		echo "### BEGIN INIT INFO" >> $(INITD)/$(NAME); \
		echo "# Provides:			nginx" >> $(INITD)/$(NAME); \
		echo "# Required-Start:		\$local_fs \$network \$syslog" >> $(INITD)/$(NAME); \
		echo "# Required-Stop:		\$local_fs \$network \$syslog" >> $(INITD)/$(NAME); \
		echo "# Default-Start:		2 3 4 5" >> $(INITD)/$(NAME); \
		echo "# Default-Stop:		0 1 6" >> $(INITD)/$(NAME); \
		echo "# Short-Description:	starts the daemon ($(NAME))" >> $(INITD)/$(NAME); \
		echo "# Description:		starts the daemon ($(NAME)) using start-stop-daemon" >> $(INITD)/$(NAME); \
		echo "### END INIT INFO" >> $(INITD)/$(NAME); \
		echo "" >> $(INITD)/$(NAME); \
		echo "/usr/local/bin/$(NAME) \$1" >> $(INITD)/$(NAME); \
		echo "exit 0" >> $(INITD)/$(NAME); \
		chmod 0755 $(INITD)/$(NAME)
		-ln -sf ../init.d/$(NAME) /etc/rc0.d/K01$(NAME); \
		-ln -sf ../init.d/$(NAME) /etc/rc1.d/K01$(NAME); \
		-ln -sf ../init.d/$(NAME) /etc/rc2.d/K01$(NAME); \
		-ln -sf ../init.d/$(NAME) /etc/rc3.d/S01$(NAME); \
		-ln -sf ../init.d/$(NAME) /etc/rc4.d/S01$(NAME); \
		-ln -sf ../init.d/$(NAME) /etc/rc5.d/S01$(NAME); \
		-ln -sf ../init.d/$(NAME) /etc/rc6.d/K01$(NAME); \
	fi

show-done-msg: check-manual-run
	@echo "Done! Daemon with name '$(NAME)' successfully generated!"

check-if-name-set:
	@if [ -z "$(NAME)" ]; then \
		echo "You must provide a NAME for daemon. For example 'make install NAME=my-service'..."; \
		exit 1; \
	fi

check-manual-run:
	@if [ "$(SINITED)" != "1" ]; then \
		echo "Aborted. You can't run this command manually"; \
		exit 1; \
	fi
