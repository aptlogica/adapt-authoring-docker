FROM node:12.18.4-stretch

ENV AAT_VER=0.10.5

RUN apt-get update && apt-get install -y \
    build-essential \
    ffmpeg libavcodec-dev libavdevice-dev\
    git nfs-common\
    libssl-dev \
  && rm -rf /var/lib/apt/lists/*

# global npm dependencies
RUN npm install -g grunt-cli \
  && npm install -g adapt-cli \
  && npm install -g rub-cli

RUN cd / \
  && wget -q https://github.com/adaptlearning/adapt_authoring/archive/v${AAT_VER}.tar.gz \
  && tar -xzf v${AAT_VER}.tar.gz \
  && mv adapt_authoring-${AAT_VER} adapt_authoring \
  && rm v${AAT_VER}.tar.gz

WORKDIR /adapt_authoring

RUN npm install --production

EXPOSE 5000

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["node", "server"]
