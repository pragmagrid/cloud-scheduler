PKGROOT     = /opt/python
NAME        = cloud-scheduler-certifi
ARCHIVENAME = certifi
VERSION     = 2017.7.27.1
RELEASE     = 0

PYTHONVER   = python2.7
RPM.EXTRAS += "AutoReq: 0"

RPM.FILES = \
/opt/python/lib/python2.7/site-packages/certifi \n \
/opt/python/lib/python2.7/site-packages/certifi-$(VERSION)*
