FROM golang:stretch AS build-env

WORKDIR /go/src/github.com/tharsis/evmos

RUN apt update
RUN apt install git -y

COPY . .

RUN make build

FROM golang:stretch

RUN apt update
RUN apt install ca-certificates jq -y

WORKDIR /root

COPY --from=build-env /go/src/github.com/tharsis/evmos/build/evmosd /usr/bin/evmosd
COPY --from=build-env /go/src/github.com/tharsis/evmos/init.sh /root/init.sh

EXPOSE 26656 26657 1317 9090 8545

RUN chmod +x /root/init.sh
RUN /root/init.sh

CMD ["evmosd" "start"]