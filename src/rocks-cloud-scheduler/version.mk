NAME = rocks-cloud-scheduler
CSNAME = cloud-scheduler
WWWROOT = /var/www/html/$(CSNAME)
PKGROOT = /opt/$(CSNAME)

VERSION   = 1.0
RELEASE = 0
 
DBNAME    = pragma
DBUSER    = pragmac
DBSCHEMA  = cs-initdb
DBADMIN   = cs-admin
DBDATA    = pragma

RPM.FILES = \
/etc/httpd/conf.d/cloud-scheduler.conf \n \
/opt/cloud-scheduler/bin/cs-config \n \
/opt/cloud-scheduler/bin/cs-uninstall \n \
/opt/cloud-scheduler/bin/sha512.py \n \
/opt/cloud-scheduler/etc/cs* 
