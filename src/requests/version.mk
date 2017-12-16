PKGROOT     = /opt/python
NAME        = cloud-scheduler-requests
ARCHIVENAME = requests
VERSION     = 2.18.4
RELEASE     = 0

RPM.EXTRAS += "AutoReq: 0"

RPM.FILES = \
/opt/python/lib/python2.7/site-packages/requests \n \
/opt/python/lib/python2.7/site-packages/requests-$(VERSION)*
