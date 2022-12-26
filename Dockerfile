FROM debian:bullseye-slim

RUN adduser --disabled-password --gecos "" --no-create-home --uid 1000 harmony

RUN apt-get update -y && apt-get install wget curl procps net-tools htop -y
RUN wget --no-check-certificate https://github.com/harmony-one/harmony/releases/download/v4.3.13/harmony && chmod +x harmony && mv harmony /usr/local/bin/harmony

RUN mkdir -p /home/harmony
RUN chown -R harmony:harmony /home/harmony

USER harmony

ENTRYPOINT ["harmony"]
