# Docker LAMP stack for Drupal dl4d
OS: Ubuntu 18.04.5 LTS

Apache: Apache/2.4.29 (Ubuntu)

MySQL Version: 5.7.34-0ubuntu0.18.04.1-log

PHP Version: 8.0.5

phpMyAdmin Version: 5.0.2

SSL with self certificate

Conposer : 2.0.13

Drush : 10.5.0

##Environment variables

- `APACHE_ROOT` tells Apache which folder within the app volume so serve as the web root.
- `MYSQL_ADMIN_PASS="mypass"` will use your given MySQL password for the `admin` user instead of the random one.
- `CREATE_MYSQL_BASIC_USER_AND_DB="true"` will create the user `user` with db `db` and password `password`. Not needed if using one of the following three `MYSQL_USER_*` variables
- `MYSQL_USER_NAME="daniel"` will use your given MySQL username instead of `user`
- `MYSQL_USER_DB="supercooldb"` will use your given database name instead of `db`
- `MYSQL_USER_PASS="supersecretpassword"` will use your given password  instead of `password`
- `PHP_UPLOAD_MAX_FILESIZE="10M"` will change PHP upload_max_filesize config value
- `PHP_POST_MAX_SIZE="10M"` will change PHP post_max_size config value
- `VAGRANT_OSX_MODE="true"` for enabling Vagrant-compatibility
- `DOCKER_USER_ID=$(id -u)` for letting Vagrant use your host user ID for mounted folders
- `DOCKER_USER_GID=$(id -g)` for letting Vagrant use your host user GID for mounted folders

## Examples


# Docker-compose
Not necessary, but usefull if you want to use with other containers.
### Docker-compose example
````
version: '3'
services:
  web:
    image: iwsp/lamp
    container_name: drupal9
    environment:
      - APACHE_ROOT=web
      - MYSQL_ADMIN_PASS=password
      - MYSQL_USER_NAME=drupal
      - MYSQL_USER_DB=drupal
      - MYSQL_USER_PASS=drupal
      - PHP_UPLOAD_MAX_FILESIZE="20M"
      - PHP_POST_MAX_SIZE="20M"
    volumes:
      - ./app:/app
      - ./mysql:/var/lib/mysql
    ports:
      - "80:80"
      - "443:443"
      - "3306:3306"
````
````
#Install drupal 9 via composer/drush
cd app
composer create-project drupal/recommended-project:^9 web
cd web
drush site-install standard --db-url='mysql://drupal:drupal@localhost/drupal' --site-name=Drupal --account-name=admin --account-pass=admin  --notify=0 --account-mail=name@mail.com -y
````