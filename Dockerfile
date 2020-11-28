FROM golang:1.15

LABEL maintainer="kihi"

ARG BASH_PROMPT="'\[\033[33m\]\n[\! \t \u@\h \w]\n\$ \[\033[37m\]'"
ARG PORT="80"

RUN go env -w GO111MODULE=on \
 && go env -w CGO_ENABLED=0

RUN go get -v github.com/go-delve/delve/cmd/dlv

ENV TZ="Asia/Tokyo"
ENV PORT=${PORT}

RUN ["bash", "-c", "echo export PS1=$BASH_PROMPT >> /root/.bashrc"]

EXPOSE ${PORT}

CMD ["bash"]
