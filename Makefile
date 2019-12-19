build:
	@docker build . -t tex-docker

run:
	@docker run -itd tex-docker sh

stop:
	@docker stop tex-docker

start:
	@docker start tex-docker

rmi:
	@docker rmi tex-docker:latest

exec:
	@docker exec -it tex-docker sh

up:
	@docker-compose up -d --build

restart:
	@docker-compose restart

down:
	@docker-compose down

re:
	@make down && \
	make up
