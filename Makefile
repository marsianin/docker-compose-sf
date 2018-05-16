# Makefile for Noveo Training

include .env

# MySQL
MYSQL_DUMPS_DIR=data/db/dumps
APP_DIR=$(shell pwd)
CONFIG_DIR=$(APP_DIR)/etc
APP_ENV=$(env)

ifndef env
	APP_ENV=prod
endif

help:
	@echo ""
	@echo "usage: make COMMAND"
	@echo ""
	@echo "Commands:"
	@echo "  clean               Clean directories for reset"
	@echo "  composer-up         Update PHP dependencies with composer"
	@echo "  docker-start        Create and start containers"
	@echo "  docker-stop         Stop and clear all services"
	@echo "  logs                Follow log output"
	@echo "  mysql-dump          Create backup of all databases"
	@echo "  mysql-restore       Restore backup of all databases"
	@echo "  test                Test application"

init:
	@$(shell cp -f $(CONFIG_DIR)/common/.$(APP_ENV).env $(APP_DIR)/.env 2> /dev/null)

clean:
	@rm -Rf web/sf/vendor

code-sniff:
	@echo "Checking/ the standard code..."
	@docker-compose exec -T php ./sf/vendor/bin/phpcs -v --standard=PSR2 sf/src

composer-up:
	@docker run --rm -v $(shell pwd)/web/sf:/app composer update -vvv

composer-setup-symfony:
	@docker run --rm -v $(shell pwd)/web:/sf composer create-project symfony/framework-standard-edition sf -vvv

docker-start: init
	docker-compose up -d

docker-stop:
	@docker-compose down -v
	@make clean

logs:
	@docker-compose logs -f

mysql-dump:
	@mkdir -p $(MYSQL_DUMPS_DIR)
	@docker exec $(shell docker-compose ps -q mysqldb) mysqldump --all-databases -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" > $(MYSQL_DUMPS_DIR)/db.sql 2>/dev/null
	@make resetOwner

mysql-restore:
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < $(MYSQL_DUMPS_DIR)/db.sql

phpmd:
	@docker-compose exec -T php \
	./sf/vendor/bin/phpmd \
	./sf \
	text cleancode,codesize,controversial,design,naming,unusedcode

test: code-sniff
	@docker-compose exec -T php ./sf/vendor/bin/phpunit --colors=always --configuration ./sf/
	@make resetOwner

.PHONY: clean test code-sniff init