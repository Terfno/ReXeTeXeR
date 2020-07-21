FROM python:alpine3.12

WORKDIR /docs

# install xetex
RUN apk update && \
  apk add openssl make texlive-xetex

# fonts
ADD ./fonts/Courier_Prime/ /usr/share/fonts/japanese/TrueType/Courier_Prime/
ADD ./fonts/Noto_Sans_JP/ /usr/share/fonts/japanese/TrueType/Noto_Sans_JP/
ADD ./fonts/Noto_Serif_JP/ /usr/share/fonts/japanese/TrueType/Noto_Serif_JP/

# latex package -> xelatex package
RUN mv /usr/share/texmf-dist/tex/latex/ /usr/share/texmf-dist/tex/xelatex/

# bibtex
ADD ./src/junsrt.bst /usr/share/texmf-dist/bibtex/bst/base/
# listing - jlisting.sty
ADD ./src/jlisting.sty /usr/share/texmf-dist/tex/xelatex/listings/
# todo fix dir | normalem - ulem.sty
ADD ./src/ulem.sty /usr/share/texmf-dist/tex/xelatex/

# style file of tsuyama thesis - c_thesis.sty
ADD ./src/c_thesis.sty /usr/share/texmf-dist/tex/xelatex/c_thesis/

RUN mktexlsr

CMD ["sh"]
