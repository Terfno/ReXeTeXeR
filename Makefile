DOCS:=`pwd`"/docs"
INAME:=terfno/rexetexer
CNAME:=rexetexer

dev:
	@docker run -it --rm alpine:3.11 sh

build:
	@docker build -t '${INAME}' .

run:
	@docker run -v ${DOCS}:/docs --name ${CNAME} -itd ${INAME} sh

exec:
	@docker exec -it ${CNAME} sh

start:
	@docker start ${CNAME}

stop:
	@docker stop ${CNAME}

# rm
rm:
	@docker rm ${CNAME}

rmi:
	@docker rmi ${INAME}
