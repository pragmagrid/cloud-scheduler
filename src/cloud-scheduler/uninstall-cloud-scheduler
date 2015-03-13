#!/bin/bash

# Remove previously installed rpm and db

rpm -el cloud-scheduler
rm -rf /opt/cloud-scheduler
rm -rf /var/www/html/cloud-scheduler
mysql -e "drop database clouddb;"
