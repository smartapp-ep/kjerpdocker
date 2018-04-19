FROM itprojectsllc/install-odoo:10.0

sed -i 's/dbfilter.*/dbfilter = ^%d$/' /mnt/config/odoo-server.conf
