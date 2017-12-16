PKGROOT     = /opt/python
NAME        = cloud-scheduler-urllib3
ARCHIVENAME = urllib3
VERSION     = 1.22
RELEASE     = 0

RPM.EXTRAS += "AutoReq: 0"

RPM.FILES = \
/opt/python/lib/python2.7/site-packages/urllib3 \n \
/opt/python/lib/python2.7/site-packages/urllib3-$(VERSION)*
