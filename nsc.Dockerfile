FROM node:8-alpine

ENV CODE /usr/src/app
ENV STAN_URL="nats://your_domain:your_node_port_map_to_4222"
ENV STAN_MONITOR_URL="nats://your_domain:your_node_port_map_to_8222"
ENV STAN_CLUSTER="cluster_name"
WORKDIR $CODE

RUN mkdir -p $CODE
COPY package.json $CODE
COPY yarn.lock $CODE
RUN yarn

ADD public $CODE/public
ADD server $CODE/server
ADD src $CODE/src

RUN yarn build-css
RUN yarn build

EXPOSE 8282
CMD ["node", "server"]
