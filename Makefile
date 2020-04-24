run:
	docker-compose up -d

drop:
	docker-compose down
	docker volume rm bcdbox_mqdata
	docker volume rm bcdbox_esdata
