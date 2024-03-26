FROM alpine:latest

# Install necessary packages
RUN apk update && \
  apk add --no-cache curl=8.5.0-r0 vim jq yq tree iputils kubectl net-tools tcpdump traceroute strace && \
  adduser -D shooter

# Set working directory and user
WORKDIR /home/shooter
USER shooter

