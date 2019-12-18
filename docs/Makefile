tex:
	@xelatex report.tex && pbibtex report.aux && xelatex report.tex && xelatex report.tex

watch:
	@chmod +x ./watch.sh && \
	./watch.sh ./report.tex 'make tex'
