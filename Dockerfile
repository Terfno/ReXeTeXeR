FROM python:alpine3.12

WORKDIR /docs

# install xetex
RUN apk update && \
  apk add openssl make texlive-xetex

# fonts
ADD ./fonts/Courier_Prime/ /usr/share/fonts/japanese/TrueType/Courier_Prime/
ADD ./fonts/Noto_Sans_JP/ /usr/share/fonts/japanese/TrueType/Noto_Sans_JP/
ADD ./fonts/Noto_Serif_JP/ /usr/share/fonts/japanese/TrueType/Noto_Serif_JP/

# bibtex cite.sty
ADD ./src/cite.sty /usr/share/texmf-dist/tex/xelatex/cite/
ADD ./src/junsrt.bst /usr/share/texmf-dist/bibtex/bst/base/
# ADD ./src/c_thesis.sty /usr/share/texmf-dist/tex/xelatex/c_thesis/
RUN mktexlsr

CMD ["sh"]
