FROM ubuntu:18.04

RUN apt-get -y update
RUN apt-get -y install software-properties-common

RUN add-apt-repository ppa:ondrej/php -y
# update package list
RUN apt-get -y update

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install tzdata

# install curl and git
RUN apt-get install -y curl git


# install php
RUN apt-get -y install php7.3 php7.3-ldap php7.3-dev php7.3-json php7.3-intl php7.3-xml php7.3-gd mcrypt php-mbstring php-pear php7.3-dev php7.3-xml php7.3-curl php7.3-cli php7.3-fpm php7.3-json php7.3-pdo php7.3-mysql php7.3-zip php7.3-gd  php7.3-mbstring php7.3-curl php7.3-xml php7.3-bcmath php7.3-json --allow-unauthenticated

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2019.list |  tee /etc/apt/sources.list.d/mssql-server-2017.list
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get -y update
RUN ACCEPT_EULA=Y apt-get -y install msodbcsql17 mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc

RUN apt-get -y install unixodbc-dev
RUN pecl install sqlsrv
RUN pecl install pdo_sqlsrv

RUN touch /etc/php/7.3/cli/conf.d/30-pdo_sqlsrv.ini
RUN touch /etc/php/7.3/cli/conf.d/20-sqlsrv.ini
RUN echo extension=pdo_sqlsrv.so > /etc/php/7.3/cli/conf.d/30-pdo_sqlsrv.ini
RUN echo extension=sqlsrv.so > /etc/php/7.3/cli/conf.d/20-sqlsrv.ini

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN exec bash

# install locales
RUN apt-get install -y locales && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
WORKDIR /var/www/html/
