PKGROOT     = /opt/python
NAME        = cloud-scheduler-idna
ARCHIVENAME = idna
VERSION     = 2.6
RELEASE     = 0

RPM.EXTRAS += "AutoReq: 0"

RPM.FILES = \
/opt/python/lib/python2.7/site-packages/idna \n \
/opt/python/lib/python2.7/site-packages/idna-$(VERSION)*

