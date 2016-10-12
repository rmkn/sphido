FROM rmkn/php7
MAINTAINER rmkn

RUN yum -y install git
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
RUN git clone https://github.com/sphido/cms.git /var/www/sphido
RUN cd /var/www/sphido && composer install --no-dev --prefer-source

COPY vhosts.conf /etc/httpd/conf.d/vhosts.conf

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

