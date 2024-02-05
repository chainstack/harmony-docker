FROM rust:1.62.0-bullseye as build

ENV VERSION=1.36.5


RUN apt-get update -y && apt-get install git binutils-dev libcurl4-openssl-dev zlib1g-dev libdw-dev libiberty-dev \
    cmake gcc g++ python3 protobuf-compiler libssl-dev pkg-config clang llvm cargo wget -y

RUN wget --no-check-certificate https://github.com/near/nearcore/archive/refs/tags/${VERSION}.tar.gz && \
    tar -xvf ${VERSION}.tar.gz && cd nearcore-${VERSION} && make neard

RUN ls && pwd
RUN cp /nearcore-${VERSION}/target/release/neard /neard

FROM debian:bullseye-slim

RUN adduser --disabled-password --gecos "" --uid 1000 near

COPY --from=build /neard /usr/local/bin/neard

RUN chown -R near:near /home/near

RUN apt-get update -y && apt-get install curl xz-utils -y

USER near

ENTRYPOINT ["neard"]
