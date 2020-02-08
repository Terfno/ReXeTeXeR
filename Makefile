docs:=`pwd`"/docs"

build:
	@docker build . -t tex-docker

run:
	@docker run -v ${docs}:/docs --name tex-docker -itd tex-docker sh

exec:
	@docker exec -it tex-docker sh

stop:
	@docker stop tex-docker

start:
	@docker start tex-docker

rm:
	@docker rm tex-docker

rmi:
	@docker rmi tex-docker:latest
