FROM itprojectsllc/install-odoo:10.0


# add material theme
# RUN git clone --depth=1 -b 10.0 https://github.com/Openworx/backend_theme.git /mnt/addons/extra
# RUN chown -R odoo /mnt/addons/extra/
# comment above coz use volume instead

# update addon path
RUN UPDATE_ADDONS_PATH=yes \
    bash -x install-odoo-saas.sh

# update config to support domains
USER root
RUN sed -i 's/dbfilter.*/dbfilter = ^%d$/' /mnt/config/odoo-server.conf


