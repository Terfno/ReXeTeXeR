FROM alpine:latest

RUN apk update && \
    apk add texlive-xetex

ADD ./docs /docs

CMD ["sh"]
