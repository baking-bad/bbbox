devkit:
	docker-compose -f docker-compose.yml -f docker-compose.devkit.yml up -d

bcd:
	docker-compose up -d

clear:
	docker volume rm bcdbox_mqdata
	docker volume rm bcdbox_esdata

drop:
	docker-compose down --remove-orphans
	$(MAKE) clear
