FROM rabbitmq:3.9.13-management-alpine

LABEL description="Docker file for rabbitmq 1"

COPY ./server-cert/ /etc/rabbitmq/cert
COPY ./client-cert/ /etc/rabbitmq/cert

# RUN chown -R root:root /etc/rabbitmq/cert

COPY ./rabbitmq.conf /etc/rabbitmq

RUN rabbitmq-plugins enable rabbitmq_auth_mechanism_ssl
