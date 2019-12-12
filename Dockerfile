FROM alpine:latest

WORKDIR /docs

# install xetex
RUN apk update && \
  apk add -U --progress -ul --no-cache texlive-xetex && \
  # ↓ for dev
  apk add -U --progress -ul --no-cache vim

# fonts
ADD ./fonts/Courier_Prime/ /usr/share/texmf-dist/fonts/truetype/Google/Courier_Prime/
ADD ./fonts/Gelasio/ /usr/share/texmf-dist/fonts/truetype/Google/Gelasio/
ADD ./fonts/Noto_Sans_JP/ /usr/share/texmf-dist/fonts/truetype/Google/Noto_Sans_JP/
ADD ./fonts/Noto_Serif_JP/ /usr/share/texmf-dist/fonts/truetype/Google/Noto_Serif_JP/
ADD ./fonts/Roboto/ /usr/share/texmf-dist/fonts/truetype/Google/Roboto/

CMD ["sh"]
