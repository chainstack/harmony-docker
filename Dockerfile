FROM debian:bullseye-slim

RUN adduser --disabled-password --gecos "" --no-create-home --uid 1000 harmony

RUN apt-get update -y && apt-get install wget curl procps net-tools htop -y
RUN wget --no-check-certificate https://s3.us-west-1.amazonaws.com/pub.harmony.one/release/linux-x86_64/v7333-v4.3.4-2-g2312aaa2/static/harmony && chmod +x harmony && mv harmony /usr/local/bin/harmony

RUN mkdir -p /home/harmony
RUN chown -R harmony:harmony /home/harmony

USER harmony

ENTRYPOINT ["harmony"]
