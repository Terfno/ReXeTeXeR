INAME:=terfno/rexetexer
TAG:=latest
CNAME:=rexetexer
TARGET:=report
CONTAINER_ENGINE:=docker

podman.%:
	@$(MAKE) $* CONTAINER_ENGINE="podman"

init:
	@${CONTAINER_ENGINE} pull ${INAME}:${TAG}

dev:
	@${CONTAINER_ENGINE} run -it --rm alpine:3.11 sh

build:
	@${CONTAINER_ENGINE} build -t '${INAME}:${TAG}' .

run:
	@${CONTAINER_ENGINE} run -it --rm -v ${CURDIR}:/docs -w /docs --name ${CNAME} ${INAME}:${TAG} sh

exec:
	@${CONTAINER_ENGINE} exec -it ${CNAME} sh

start:
	@${CONTAINER_ENGINE} start ${CNAME}

stop:
	@${CONTAINER_ENGINE} stop ${CNAME}

# rm
rm:
	@${CONTAINER_ENGINE} rm ${CNAME}

rmi:
	@${CONTAINER_ENGINE} rmi ${INAME}:${TAG}

# tex
tex:
	@rm -f ${TARGET}.aux && rm -f ${TARGET}.bbl && rm -f ${TARGET}.blg && rm -f ${TARGET}.log && rm -f ${TARGET}.toc &&\
	xelatex ${TARGET}.tex && pbibtex report.aux && xelatex ${TARGET}.tex && xelatex ${TARGET}.tex

watch:
	@echo "start watching" && \
	./watch.sh ./${TARGET}.tex 'make tex'
