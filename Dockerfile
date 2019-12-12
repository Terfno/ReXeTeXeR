FROM alpine:latest

WORKDIR /docs

# install xetex
RUN apk update && \
  apk add -U --progress -ul --no-cache texlive-xetex && \
  # ↓ for dev
  apk add -U --progress -ul --no-cache vim

# fonts
ADD ./fonts/Courier_Prime/ /usr/share/fonts/japanese/TrueType/Courier_Prime/
ADD ./fonts/Gelasio/ /usr/share/fonts/japanese/TrueType/Gelasio/
ADD ./fonts/Noto_Sans_JP/ /usr/share/fonts/japanese/TrueType/Noto_Sans_JP/
ADD ./fonts/Noto_Serif_JP/ /usr/share/fonts/japanese/TrueType/Noto_Serif_JP/
ADD ./fonts/Roboto/ /usr/share/fonts/japanese/TrueType/Roboto/

# bibtex cite.sty
ADD ./pack/cite.sty /usr/share/texmf-dist/tex/xelatex/cite/
ADD ./pack/junsrt.bst /usr/share/texmf-dist/bibtex/bst/base/
RUN mktexlsr

CMD ["sh"]
