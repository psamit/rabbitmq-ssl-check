# !/bin/bash
git clone https://github.com/michaelklishin/tls-gen .tls-gen
cd .tls-gen/basic
make PASSWORD=bunnies
make verify
make info
ls -l ./result
sleep 1
cp result/ca_certificate.pem ../../server-cert/
cp result/server_certificate.pem ../../server-cert/
cp result/server_key.pem ../../server-cert/

cp result/ca_certificate.pem ../../client-cert/
cp result/client_certificate.pem ../../client-cert/
cp result/client_key.pem ../../client-cert/
