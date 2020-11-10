INAME:=terfno/rexetexer:tsuyama
CNAME:=tsuyama-rexetexer
TARGET:=report.tex

init:
	@docker pull ${INAME}

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
	@echo "start watching" && \
	chmod +x ./watch.sh && \
	./watch.sh ./${TARGET} 'make tex'
