PKGROOT     = /opt/python
NAME        = cloud-scheduler-MySQL-python
ARCHIVENAME = MySQL-python
VERSION     = 1.2.5
RELEASE     = 0

RPM.EXTRAS += "AutoReq: 0"

RPM.FILES = \
/opt/python/lib/python2.7/site-packages/MySQLdb \n \
/opt/python/lib/python2.7/site-packages/_mysql* \n \
/opt/python/lib/python2.7/site-packages/MySQL_python-$(VERSION)*
