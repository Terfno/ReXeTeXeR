FROM alpine:3.11

WORKDIR /docs

# install xetex
RUN apk update && \
  apk add openssl make texlive-xetex && \
  # latex package -> xelatex package
  mv /usr/share/texmf-dist/tex/latex/ /usr/share/texmf-dist/tex/xelatex/

# bibtex
ADD ./src/junsrt.bst /usr/share/texmf-dist/bibtex/bst/base/

# BXjscls
ADD ./src/BXjscls/*.* /usr/share/texmf-dist/tex/xelate/bxjscls/

RUN mktexlsr

CMD ["sh"]
