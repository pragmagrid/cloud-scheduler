NAME = cloud-scheduler
WWWROOT = /var/www/html/$(NAME)
PKGROOT = /opt/$(NAME)
PKGNAME = cloud-scheduler-gui
VERSION   = 1.0
RELEASE   = 0
PERLFILE = $(PKGNAME)/UI/node_modules/node-sass/src/libsass/script/test-leaks.pl

TARBALL_POSTFIX = tar.gz

RPM.EXTRAS = "AutoReq: no"

RPM.FILES = \
/opt/cloud-scheduler/UI \n \
/opt/cloud-scheduler/etc/pragma.sql \n \
/var/www/html/cloud-scheduler

#RPM.EXTRAS  = %define __os_install_post /usr/lib/rpm/brp-python-bytecompile python
