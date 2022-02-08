FROM rabbitmq:3.9.13-management-alpine
LABEL description="Docker file for rabbitmq"

# RUN apk add --update nodejs npm

copy server-cert /etc/rabbitmq/server-cert
copy rabbitmq.conf /etc/rabbitmq/

# RUN mkdir -p /usr/src/
# WORKDIR /usr/src/

# copy package.json /usr/src/
# copy reconnect.js /usr/src/
# copy client-cert /usr/src/client-cert


# RUN npm install .


# CMD ["npm", "start"]


