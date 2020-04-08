TARGET:=report.tex

tex:
	@xelatex ${TARGET} && pbibtex report.aux && xelatex ${TARGET} && xelatex ${TARGET}

watch:
	@chmod +x ./watch.sh && \
	./watch.sh ./${TARGET} 'make tex'
