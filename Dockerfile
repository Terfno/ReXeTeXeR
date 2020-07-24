FROM python:alpine3.12

WORKDIR /docs

# install xetex
RUN apk update && \
  apk add openssl make texlive-xetex

# fonts
ADD ./fonts/Courier_Prime/ /usr/share/fonts/japanese/TrueType/Courier_Prime/	ADD ./fonts/Courier_Prime/ /usr/share/fonts/japanese/TrueType/Courier_Prime/
ADD ./fonts/Noto_Sans_JP/ /usr/share/fonts/japanese/TrueType/Noto_Sans_JP/	ADD ./fonts/Noto_Sans_JP/ /usr/share/fonts/japanese/TrueType/Noto_Sans_JP/
ADD ./fonts/Noto_Serif_JP/ /usr/share/fonts/japanese/TrueType/Noto_Serif_JP/	ADD ./fonts/Noto_Serif_JP/ /usr/share/fonts/japanese/TrueType/Noto_Serif_JP/

# latex package -> xelatex package
RUN mv /usr/share/texmf-dist/tex/latex/ /usr/share/texmf-dist/tex/xelatex/

# for bibtex
ADD ./src/junsrt.bst /usr/share/texmf-dist/bibtex/bst/base/
# listing - jlisting.sty
ADD ./src/jlisting.sty /usr/share/texmf-dist/tex/xelatex/listings/
# todo fix dir | normalem - ulem.sty
ADD ./src/ulem.sty /usr/share/texmf-dist/tex/xelatex/
# txfonts
ADD ./src/txfonts/afm/ /usr/share/texmf-dist/fonts/afm/txr/
ADD ./src/txfonts/pfb/ /usr/share/texmf-dist/fonts/type1/txr/
ADD ./src/txfonts/tfm/ /usr/share/texmf-dist/fonts/tfm/txr/
ADD ./src/txfonts/vf/ /usr/share/texmf-dist/fonts/vf/txr/
ADD ./src/txfonts/input /usr/share/texmf-dist/tex/xelatex/txr/
ADD ./src/txfonts/dvips/ /usr/share/texmf-dist/dvips/config/
RUN echo p +txr.map >> /usr/share/texmf-dist/dvips/config/config.ps

# style file of thesis at tsuyama kosen - c_thesis.sty
ADD ./src/c_thesis.sty /usr/share/texmf-dist/tex/xelatex/c_thesis/

RUN mktexlsr

CMD ["sh"]
