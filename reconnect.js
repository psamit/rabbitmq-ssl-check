const amqp = require('amqplib');
const path = require('path');
const fs = require('fs');
const RABBIT_MQ_URL = `amqps://amit:amit@localhost:3111`;
const CLIENT_CERT = 'client-cert';

const opts = {
  ca: [fs.readFileSync(path.join(__dirname, CLIENT_CERT, 'ca_certificate.pem'))],
  cert: fs.readFileSync(path.join(__dirname, CLIENT_CERT, 'client_certificate.pem')),
  key: fs.readFileSync(path.join(__dirname, CLIENT_CERT, 'client_key.pem')),
  passphrase: 'bunnies',
  fail_if_no_peer_cert: true,
  verify: 'verify_peer'
};


const q = 'tasks';

const open = amqp.connect(`${RABBIT_MQ_URL}?heartbeat=60`, opts);

// Publisher
open.then((conn) => {
  return conn.createChannel();
}).then(async (ch) => {
  return ch.assertQueue(q).then((ok) => {
    const p1 = ch.sendToQueue(q, Buffer.from('something to do'))
    const p2 = ch.sendToQueue(q, Buffer.from('something to do 1'))
    return Promise.all([p1, p2]);
  });
}).catch(console.warn);

// Consumer
open.then((conn) => {
  return conn.createChannel();
}).then(async (ch) => {
  return ch.assertQueue(q).then((ok) => {
    return ch.consume(q, (msg) => {
      if (msg !== null) {
        console.log(msg.content.toString());
        ch.ack(msg);
      }
    });
  });
}).catch(console.warn);
