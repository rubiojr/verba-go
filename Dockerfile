FROM golang:1.23-alpine AS build
RUN apk add --no-cache --update go gcc g++

ARG TARGETOS=linux
ARG TARGETARCH=arm64
ARG TARGETVARIANT=

ENV BUILDX_ARCH="${TARGETOS:-linux}_${TARGETARCH:-amd64}"


WORKDIR /usr/src/app

ENV CGO_ENABLED=1
RUN go install --tags fts5 github.com/rubiojr/rsx@v0.5.5

COPY main.risor .
COPY lib lib

RUN rsx build -o /usr/local/bin/app

FROM alpine:latest

WORKDIR /tmp
COPY --from=build /usr/local/bin/app /usr/local/bin/app

VOLUME data

RUN mkdir -p /data/db
RUN /usr/local/bin/app --db /data/db/verba.db createdb

#ENV RSX_DEBUG=1

CMD ["/usr/local/bin/app", "--db", "/data/db/verba.db", "serve", "--sync"]
