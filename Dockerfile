FROM rabbitmq:3.9.13-management-alpine

LABEL description="Docker file for rabbitmq"

COPY ./server-cert/ /etc/rabbitmq/cert
RUN chown -R rabbitmq:rabbitmq /etc/rabbitmq/cert
COPY ./rabbitmq.conf /etc/rabbitmq


