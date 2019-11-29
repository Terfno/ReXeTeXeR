git:
	git add . && \
	git commit && \
	git push

d/build:
	docker build . -t tex-docker

d/run:
	docker run -itd tex-docker sh

d/exec:
	docker exec -it tex-docker sh

dc/up:
	docker-compose up -d --build

dc/restart:
	docker-compose restart

dc/down:
	docker-compose down --rmi all
