# docker-php7-sqlsrv
Docker for PHP7 with Ms Sql Server , ldap,mcrypt, sqlsrv php built-in

To run:

 docker run -d -p {localport}:8080 -v {localservice}:/var/www/html --name microservicos php7sqlsrv:latest php -S 0.0.0.0:8080 {dir}/index.php

