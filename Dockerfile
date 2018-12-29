FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install -y curl gnupg \
    && curl -fsSL https://deb.nodesource.com/setup_8.x -o /tmp/node_setup.sh \
    && bash /tmp/node_setup.sh \
    && rm /tmp/node_setup.sh \
    && apt-get install -y nodejs git make g++ libboost-dev libboost-system-dev libboost-date-time-dev \
    && git clone https://github.com/ALLRiPPED/cn-node-proxy /cn-node-proxy \
    && cd /cn-node-proxy \
    && npm install \
    && cp -n config_example.json config.json \
    && openssl req -subj "/C=IT/ST=Pool/L=Daemon/O=Mining Pool/CN=mining.proxy" -newkey rsa:2048 -nodes -keyout cert.key -x509 -out cert.pem -days 36500

EXPOSE 8080 8443 3333

WORKDIR /cn-node-proxy
CMD ./update.sh && node proxy.js
