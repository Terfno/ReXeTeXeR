FROM alpine:3.8

# install xetex
RUN apk --no-cache add openssl make texlive-xetex && \
  # latex package -> xelatex package
  mv /usr/share/texmf-dist/tex/latex/ /usr/share/texmf-dist/tex/xelatex/

# bibtex
ADD ./src/junsrt.bst /usr/share/texmf-dist/bibtex/bst/base/

# BXjscls
ADD ./src/BXjscls/*.* /usr/share/texmf-dist/tex/xelate/bxjscls/

RUN mktexlsr
