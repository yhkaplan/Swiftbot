# TODO: pin version for FROM image
FROM swift:latest as builder
# Deps for Vapor websockets (cannot find cstack ctls )
# Probably only need libssl-dev and or openssl
RUN apt-get update && \
apt-get install -y libmysqlclient20 libmysqlclient-dev openssl libssl-dev
COPY ./ /root
WORKDIR /root
RUN swift --version
RUN swift build -c release

FROM swift:slim
WORKDIR /root
COPY --from=builder /root .
CMD [".build/x86_64-unknown-linux/release/SwiftBot"]
