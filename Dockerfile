FROM golang:1.14.2

RUN apt-get install -y git
RUN cd ~ && git clone https://github.com/inconshreveable/ngrok.git
RUN cd ~/ngrok && mkdir cert && cd cert && \
    openssl genrsa -out rootCA.key 2048 && \
    openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=tunnel.liaolangsheng.com" -days 5000 -out rootCA.pem && \
    openssl genrsa -out device.key 2048 && \
    openssl req -new -key device.key -subj "/CN=tunnel.liaolangsheng.com" -out device.csr && \
    openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 5000 && \
    yes|cp rootCA.pem ~/ngrok/assets/client/tls/ngrokroot.crt && \
    yes|cp device.crt ~/ngrok/assets/server/tls/snakeoil.crt && \
    yes|cp device.key ~/ngrok/assets/server/tls/snakeoil.key

RUN cd ~/ngrok && GOOS=linux GOARCH=amd64 make release-server

RUN cd ~/ngrok && GOOS=linux GOARCH=amd64 make release-client

RUN cd ~/ngrok && \
    echo '#!/bin/bash'"\n" \
    'workdir=$(cd $(dirname $0); pwd)'"\n" \
    'cd $workdir'"\n" \
    './bin/ngrokd \
    -tlsKey="assets/server/tls/snakeoil.key" \
    -tlsCrt="assets/server/tls/snakeoil.crt" \
    -domain="tunnel.liaolangsheng.com" \
    -httpAddr=":18081" \
    -httpsAddr=":18082" \
    -tunnelAddr=":18083"' > start_ngrokd.sh

ADD ngrok.cfg /root/ngrok/bin/
ADD entrypoint.sh /root/

RUN cd ~/ngrok && \
    echo '#!/bin/bash'"\n" \
    'workdir=$(cd $(dirname $0); pwd)'"\n" \
    'cd $workdir'"\n" \
    './bin/ngrok -config=bin/ngrok.cfg start-all' > start_ngrok.sh

RUN cd ~/ngrok && chmod +x start_ngrokd.sh && chmod +x start_ngrok.sh
RUN chmod +x /root/entrypoint.sh

EXPOSE 18081 18082 18083

CMD ["server"]
ENTRYPOINT ["/root/entrypoint.sh"]