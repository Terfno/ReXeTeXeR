FROM python:alpine3.12

WORKDIR /docs

# install xetex
RUN apk update && \
  apk add openssl make texlive-xetex

# fonts
ADD ./fonts/Courier_Prime/ /usr/share/fonts/japanese/TrueType/Courier_Prime/
ADD ./fonts/Noto_Sans_JP/ /usr/share/fonts/japanese/TrueType/Noto_Sans_JP/
ADD ./fonts/Noto_Serif_JP/ /usr/share/fonts/japanese/TrueType/Noto_Serif_JP/

# bibtex - cite.sty
ADD ./src/cite.sty /usr/share/texmf-dist/tex/xelatex/cite/
ADD ./src/junsrt.bst /usr/share/texmf-dist/bibtex/bst/base/

# BXjscls
ADD ./src/BXjscls-2.1/*.cls /usr/share/texmf-dist/tex/xelatex/bxjscls/
ADD ./src/BXjscls-2.1/*.def /usr/share/texmf-dist/tex/xelatex/bxjscls/
ADD ./src/BXjscls-2.1/*.sty /usr/share/texmf-dist/tex/xelatex/bxjscls/
ADD ./src/BXjscls-2.1/*.dtx /usr/share/texmf-dist/source/latex/bxjscls/
ADD ./src/BXjscls-2.1/*.ins /usr/share/texmf-dist/source/latex/bxjscls/
ADD ./src/BXjscls-2.1/*.pdf /usr/share/texmf-dist/doc/latex/bxjscls/
ADD ./src/BXjscls-2.1/*.tex /usr/share/texmf-dist/doc/latex/bxjscls/

# style file of tsuyama thesis - c_thesis.sty
ADD ./src/c_thesis.sty /usr/share/texmf-dist/tex/xelatex/c_thesis/
# todo fix dir | url - url.sty
ADD ./src/url/ /usr/share/texmf-dist/tex/xelatex/

# listing - jlisting.sty
ADD ./src/jlisting.sty /usr/share/texmf-dist/tex/xelatex/listings/

# todo fix dir | normalem - ulem.sty
ADD ./src/ulem/ /usr/share/texmf-dist/tex/xelatex/

RUN mktexlsr

CMD ["sh"]
