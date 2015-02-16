PKG_NAME := ostack-monitor
DESTDIR ?= $(CURDIR)/output
PKG_DIR := $(DESTDIR)/$(PKG_NAME)
DEB_CTL_DIR := $(PKG_DIR)/DEBIAN
ETC_DIR := $(PKG_DIR)/etc
PY_PKGS := $(PKG_DIR)/usr/lib/python2.7/dist-packages/oschecks
VERSION := 1.0

.PHONY: all
all: 
	@echo "package"
	@echo "packageclean"

.PHONY: installdirs
installdirs:
	mkdir -p $(DESTDIR)
	mkdir -p $(DEB_CTL_DIR)
	mkdir -p $(ETC_DIR)
	mkdir -p $(PY_PKGS)

.PHONY: package
package: installdirs
	cp DEBIAN/* $(DEB_CTL_DIR)
	sed -i "s/<VERSION>/$(VERSION)/" $(DEB_CTL_DIR)/control
	cp -R oschecks/* $(PY_PKGS)
	fakeroot dpkg -b $(PKG_DIR) $(DESTDIR)/$(PKG_NAME).deb

.PHONY: packageclean
packageclean:
	-rm -rf $(DESTDIR)



