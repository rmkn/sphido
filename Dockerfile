FROM centos:6
MAINTAINER rmkn
RUN yum -y update
RUN yum -y install epel-release
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN yum -y install --enablerepo=remi,remi-php70 httpd php70-php php70-php-mbstring git
RUN ln -s /usr/bin/php70 /usr/bin/php
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
RUN git clone https://github.com/sphido/cms.git /var/www/sphido
RUN cd /var/www/sphido && composer install --no-dev --prefer-source

EXPOSE 80
COPY vhosts.conf /etc/httpd/conf.d/vhosts.conf
COPY security.conf /etc/httpd/conf.d/securpty.conf
COPY init.sh /tmp/init.sh
RUN /tmp/init.sh && rm /tmp/init.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

