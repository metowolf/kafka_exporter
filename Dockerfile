FROM golang:1.16-alpine AS build

WORKDIR /app

COPY . /app

RUN apk add upx --upgrade \
  && go build -ldflags="-s -w" \
  && upx kafka_exporter


FROM alpine

COPY --from=build /app/kafka_exporter /bin/kafka_exporter

EXPOSE 9308

ENTRYPOINT [ "/bin/kafka_exporter" ]