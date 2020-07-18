INAME:=terfno/rexetexer:tsuyama
CNAME:=tsuyama-rexetexer
TARGET:=report.tex

dev:
	@docker run -it --rm alpine:3.11 sh

build:
	@docker build -t '${INAME}' .

run:
	@docker run -v ${PWD}:/docs --name ${CNAME} -itd ${INAME} sh

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

# tex
tex:
	@xelatex ${TARGET} && pbibtex report.aux && xelatex ${TARGET} && xelatex ${TARGET}

watch:
	@chmod +x ./watch.sh && \
	./watch.sh ./${TARGET} 'make tex'
