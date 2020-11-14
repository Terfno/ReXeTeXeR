FROM alpine:3.11

WORKDIR /docs

# install xetex
RUN apk update && \
  apk add openssl make texlive-xetex

# bibtex cite.sty
ADD ./src/cite.sty /usr/share/texmf-dist/tex/xelatex/cite/
ADD ./src/junsrt.bst /usr/share/texmf-dist/bibtex/bst/base/

# BXjscls
ADD ./src/BXjscls/*.* /usr/share/texmf-dist/tex/xelate/bxjscls/

RUN mktexlsr

CMD ["sh"]
