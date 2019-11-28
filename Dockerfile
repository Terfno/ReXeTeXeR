FROM alpine:latest

RUN apk update && \
  apk add -U --progress -ul --no-cache texlive-xetex

ADD ./docs /docs

CMD ["sh"]
