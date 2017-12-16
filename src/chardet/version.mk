PKGROOT     = /opt/python
NAME        = cloud-scheduler-chardet
ARCHIVENAME = chardet
VERSION     = 3.0.4
RELEASE     = 0

RPM.EXTRAS += "AutoReq: 0"

RPM.FILES = \
/opt/python/bin/chardetect \n \
/opt/python/lib/python2.7/site-packages/chardet \n \
/opt/python/lib/python2.7/site-packages/chardet-$(VERSION)*
