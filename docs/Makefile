filename:=report

tex:
	@xelatex $(filename).tex && pbibtex $(filename).aux && xelatex $(filename).tex && xelatex $(filename).tex

watch:
	@chmod +x ./watch.sh && \
	./watch.sh ./$(filename).tex 'make tex'
