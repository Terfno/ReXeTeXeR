FROM python:alpine3.12

WORKDIR /docs

# install xetex
RUN apk update && \
  apk add openssl make texlive-xetex

# latex package -> xelatex package
RUN mv /usr/share/texmf-dist/tex/latex/ /usr/share/texmf-dist/tex/xelatex/

# for bibtex
ADD ./src/junsrt.bst /usr/share/texmf-dist/bibtex/bst/base/

# jlisting.sty
ADD ./src/jlisting.sty /usr/share/texmf-dist/tex/xelatex/listings/

# ulem.sty
ADD ./src/ulem.sty /usr/share/texmf-dist/tex/xelatex/ulem

# here.sty
ADD ./src/here.sty /usr/share/texmf-dist/tex/xelatex/here/

# txfonts for some other packages.
ADD ./src/txfonts/afm/ /usr/share/texmf-dist/fonts/afm/txr/
ADD ./src/txfonts/pfb/ /usr/share/texmf-dist/fonts/type1/txr/
ADD ./src/txfonts/tfm/ /usr/share/texmf-dist/fonts/tfm/txr/
ADD ./src/txfonts/vf/ /usr/share/texmf-dist/fonts/vf/txr/
ADD ./src/txfonts/input/ /usr/share/texmf-dist/tex/xelatex/txr/
ADD ./src/txfonts/dvips/ /usr/share/texmf-dist/dvips/config/
RUN echo p +txr.map >> /usr/share/texmf-dist/dvips/config/config.ps

# BXjscls
ADD ./src/BXjscls/*.cls /usr/share/texmf-dist/tex/xelate/bxjscls/
ADD ./src/BXjscls/*.def /usr/share/texmf-dist/tex/xelate/bxjscls/
ADD ./src/BXjscls/*.sty /usr/share/texmf-dist/tex/xelate/bxjscls/

RUN mktexlsr

CMD ["sh"]
