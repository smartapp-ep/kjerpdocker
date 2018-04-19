FROM itprojectsllc/install-odoo:10.0

# update config to support domains
USER root
RUN sed -i 's/dbfilter.*/dbfilter = ^%d$/' /mnt/config/odoo-server.conf
