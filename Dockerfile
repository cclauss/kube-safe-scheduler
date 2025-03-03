FROM golang:1.10-alpine as builder
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64

ARG VERSION=0.0.1

# build
WORKDIR /go/src/kube-safe-scheduler
COPY . .
RUN go install -ldflags "-s -w -X main.version=$VERSION" kube-safe-scheduler

# runtime image
FROM gcr.io/google_containers/ubuntu-slim:0.14
COPY --from=builder /go/bin/kube-safe-scheduler /usr/bin/kube-safe-scheduler
ENTRYPOINT ["kube-safe-scheduler"]
