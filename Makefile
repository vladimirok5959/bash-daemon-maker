RELEASEURL:="https://github.com/vladimirok5959/bash-empty-daemon/releases/download/latest/daemon.zip"
BINDIR:=/usr/local/bin
LROTDIR:=/etc/logrotate.d
INSTALLDIR:=/etc
SINITED:="0"

default: check info

install: check dir-test download create-link create-logrotate show-done-msg

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
		ln -sf $(INSTALLDIR)/$(NAME).sh $(BINDIR)/$(NAME); \
		chmod 744 $(BINDIR)/$(NAME); \
	fi

create-logrotate: check-manual-run check-if-name-set
	@if [ ! -z "$(NAME)" ]; then \
		echo "Create config file for logrotate..."; \
		echo "$(INSTALLDIR)/logs/all.log {" > $(LROTDIR)/$(NAME); \
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
