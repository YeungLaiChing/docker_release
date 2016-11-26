FROM amazonlinux

# Install dependencies
RUN yum install -y \
    httpd \
    java \
    php \
    openssh-server \
&& echo "<?php phpinfo(); ?>" > /var/www/html/test.php \
&& chown -R apache /var/www/html \
&& mkdir /var/log/apache \
&& mkdir /var/run/sshd \
&& echo 'root:password_' | chpasswd \
&& sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
&& sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
&& echo "export VISIBLE=now" >> /etc/profile \
&& groupadd -r lapigo \
&& useradd -r -g lapigo lapigopa1 \
&& echo 'lapigopa1:password_' | chpasswd \
&& mkdir /sysp \
&& mkdir /sysp/script \
&& echo '/usr/sbin/httpd -k start &' >> /sysp/script/startup.sh \
&& echo '/usr/sbin/sshd -D &' >> /sysp/script/startup.sh \
&& echo '/apps/script/startup.sh & ' >> /sysp/script/startup.sh \
&& echo 'tail -f /dev/null' >> /sysp/script/startup.sh \
&& chmod 755 /sysp/script/startup.sh

VOLUME ["/apps"]

ENV APACHE_RUN_USER apache
ENV APACHE_LOG_DIR /var/log/apache

ENV NOTVISIBLE "in users profile"

EXPOSE 22
EXPOSE 80


CMD ["/bin/bash","/sysp/script/startup.sh"]
