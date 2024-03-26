FROM alpine:latest

RUN apk update && \
  apk add --no-cache curl vim jq yq tree iputils kubectl