up:
	docker-compose up --build --no-deps --detach --remove-orphans

down:
	docker-compose down

stop:
	docker-compose stop

restart: down up
	$(info Restart completed)

upgrade: ## Upgrade docker containers
	docker-compose build --pull
	make up

destroy: ## Destroy containers/volumes (keep sources app folders)
	make stop
	docker-compose down --rmi all --remove-orphans

rebuild: ## Rebuild docker container (destroy & upgrade)
	make destroy
	make upgrade

state:
	docker ps --format=table

docker-cleanup: ## Will remove every docker container and everything what is related, make sure you know what you are doing!
	docker stop `docker ps -qa` && docker system prune -a -f && docker volume prune -f

logs: ## Show docker logs
	docker-compose logs -f --tail=100 $(ARGS)

php:
	docker-compose exec php bash

mysql:
	docker-compose exec mysql bash

postgres:
	docker-compose exec postgres bash

