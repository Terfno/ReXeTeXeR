FROM alpine:latest

RUN apk update && \
  apk add -U --progress -ul --no-cache texlive-xetex && \
  # ↓ for dev
  apk add -U --progress -ul --no-cache vim

CMD ["sh"]
