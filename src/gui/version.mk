NAME = cloud-scheduler
WWWROOT = /var/www/html/$(NAME)
PKGROOT = /opt/$(NAME)
PKGNAME = cloud-scheduler-gui

VERSION   = 1.0
RELEASE   = 0

DBNAME    = pragma
DBUSER    = pragmac
DBSCHEMA  = cs-initdb
DBDATA    = pragma

PERLFILE = $(PKGNAME)/UI/node_modules/node-sass/src/libsass/script/test-leaks.pl

TARBALL_POSTFIX = tar.gz

PY.PATH = /opt/python/bin/python2.7
#RPM.EXTRAS  = %define __os_install_post /usr/lib/rpm/brp-python-bytecompile  $(PY.PATH)
RPM.EXTRAS = "AutoReq: no"

