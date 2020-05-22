.PHONY: bbbox custom

bcd:
	docker-compose pull
	docker-compose up -d

bcd-stop:
	docker-compose down

bcd-clear:
	docker volume rm bbbox_mqdata
	docker volume rm bbbox_esdata

bbbox:
	docker-compose pull
	docker-compose -f docker-compose.yml -f docker-compose.bbbox.yml up -d

custom:
	docker-compose -f docker-compose.yml -f docker-compose.custom.yml up -d

drop:
	docker-compose down --remove-orphans
	$(MAKE) bcd-clear
