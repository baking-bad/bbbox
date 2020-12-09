TAG=2.6
 
.PHONY: bbbox custom

bcd:
	TAG=3.2 COMPOSE_PROJECT_NAME=bbbox docker-compose -f docker-compose.sandbox.yml pull
	TAG=3.2 COMPOSE_PROJECT_NAME=bbbox docker-compose -f docker-compose.sandbox.yml up -d

bcd-stop:
	docker-compose -f docker-compose.sandbox.yml down

bcd-clear:
	docker volume rm bbbox_mqdata
	docker volume rm bbbox_esdata
	docker volume rm bbbox_db

bbbox:
	TAG=$(TAG) docker-compose pull
	TAG=$(TAG) docker-compose -f docker-compose.yml -f docker-compose.bbbox.yml up -d

custom:
	docker-compose -f docker-compose.yml -f docker-compose.custom.yml up -d

drop:
	docker-compose down --remove-orphans -v

aliases:
	docker exec -it api aliases

migration:
	docker exec -it api migration

s3-creds:
	docker exec -it elastic bash -c 'bin/elasticsearch-keystore add --force --stdin s3.client.default.access_key <<< "$$AWS_ACCESS_KEY_ID"'
	docker exec -it elastic bash -c 'bin/elasticsearch-keystore add --force --stdin s3.client.default.secret_key <<< "$$AWS_SECRET_ACCESS_KEY"'
	docker exec -it api esctl reload_secure_settings

s3-repo:
	docker exec -it api esctl create_repository

s3-restore:
	docker exec -it api esctl restore

s3-snapshot:
	docker exec -it api esctl snapshot

db-dump:
	docker exec -it db pg_dump -c bcd > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql

db-restore:
	docker exec -i db psql --username $(USER) -v ON_ERROR_STOP=on bcd < $(BACKUP)

ps:
	docker ps --format "table {{.Names}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}"