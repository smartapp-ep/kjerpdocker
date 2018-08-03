FROM itprojectsllc/install-odoo:10.0



# add material theme
# RUN git clone --depth=1 -b 10.0 https://github.com/Openworx/backend_theme.git /mnt/addons/extra
# RUN chown -R odoo /mnt/addons/extra/
# comment above coz use volume instead

USER root

# Set OS timezone to China
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# Set Odoo timezone to China (will be set at startup thanks to Odoo
# parameter substitution)
ENV ODOO_TIMEZONE=Asia/Shanghai

# CN fonts & xlrd
RUN apt-get update && \
  apt-get -y install ttf-wqy-zenhei && \
  pip install xlrd


# install dependence for alipay
RUN pip install pycrypto


# update addon path
RUN UPDATE_ADDONS_PATH=yes \
    bash -x install-odoo-saas.sh

# update config to support domains

RUN sed -i 's/dbfilter.*/dbfilter = ^%d$/' /mnt/config/odoo-server.conf
# RUN echo "Asia/shanghai" > /etc/timezone;

# pull translations
RUN git clone --depth=1 https://github.com/smartapp-ep/kjerp-translation-cn.git /tmp && \
    cp -vr /tmp/addons/* /mnt/odoo-source/addons

# patches
COPY /patches/addons/hr_expense/wizard/hr_expense_register_payment.py /mnt/odoo-source/addons/hr_expense/wizard/hr_expense_register_payment.py

USER odoo
VOLUME ["/mnt/config"]

