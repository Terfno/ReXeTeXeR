INAME:=terfno/rexetexer
CNAME:=rexetexer
TARGET:=report.tex
CONTAINER_ENGINE:=docker

dev:
	@${CONTAINER_ENGINE} run -it --rm alpine:3.11 sh

build:
	@${CONTAINER_ENGINE} build -t '${INAME}' .

run:
	@${CONTAINER_ENGINE} run -v ${PWD}:/docs --name ${CNAME} -itd ${INAME} sh

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
	@${CONTAINER_ENGINE} rmi ${INAME}

# tex
tex:
	@xelatex ${TARGET} && pbibtex report.aux && xelatex ${TARGET} && xelatex ${TARGET}

watch:
	@chmod +x ./watch.sh && \
	./watch.sh ./${TARGET} 'make tex'

podman.%:
	@$(MAKE) $* CONTAINER_ENGINE="podman"
