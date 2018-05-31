# Nginx PHP MySQL [![Build Status](https://travis-ci.org/nanoninja/docker-nginx-php-mysql.svg?branch=master)](https://travis-ci.org/nanoninja/docker-nginx-php-mysql) [![GitHub version](https://badge.fury.io/gh/nanoninja%2Fdocker-nginx-php-mysql.svg)](https://badge.fury.io/gh/nanoninja%2Fdocker-nginx-php-mysql)

## Use Makefile

When developing, you can use [Makefile](https://en.wikipedia.org/wiki/Make_(software)) for doing the following operations :

| Name          | Description                                  |
|---------------|----------------------------------------------|
| clean         | Clean directories for reset                  |
| code-sniff    | Check the API with PHP Code Sniffer (`PSR2`) |
| composer-up   | Update PHP dependencies with composer        |
| docker-start  | Create and start containers                  |
| docker-stop   | Stop and clear all services                  |     |
| logs          | Follow log output                            |
| mysql-dump    | Create backup of all databases               |
| mysql-restore | Restore backup of all databases              |
| phpmd         | Analyse the API with PHP Mess Detector       |
| test          | Test application with phpunit                |

### Start docker containers

Start the application :

```sh
sudo make docker-start env=prod
```

Check logs :

```sh
sudo make logs
```

Open in browser :
 - http://localhost:8000/app.php (application)
 - http://localhost:8080 (PhpMyAdmin)

```sh
sudo make logs
```

Show help :

```sh
make help
```

___

## Use Docker commands

### Testing PHP application with PHPUnit

```sh
sudo docker-compose exec -T php ./app/vendor/bin/phpunit --colors=always --configuration ./sf
```

### Fixing standard code with [PSR2](http://www.php-fig.org/psr/psr-2/)

```sh
sudo docker-compose exec -T php ./sf/vendor/bin/phpcbf -v --standard=PSR2 ./sf/src
```

### Checking the standard code with [PSR2](http://www.php-fig.org/psr/psr-2/)

```sh
sudo docker-compose exec -T php ./sf/vendor/bin/phpcs -v --standard=PSR2 ./sf/src
```

### Analyzing source code with [PHP Mess Detector](https://phpmd.org/)

```sh
sudo docker-compose exec -T php ./sf/vendor/bin/phpmd ./sf/src text cleancode,codesize,controversial,design,naming,unusedcode
```

### Checking installed PHP extensions

```sh
sudo docker-compose exec php php -m
```

### Handling database

#### MySQL shell access

```sh
sudo docker exec -it mysql bash
```

and

```sh
mysql -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD"
```

#### Blackfire
docker run -it --rm blackfire/blackfire blackfire --client-id=YOUR_CLIENT_ID --client-token=YOUR_TOKEN curl URL