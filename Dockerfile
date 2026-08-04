FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl gnupg gcc g++ make \
    && curl -fsSL https://deb.nodesource.com/setup_24.x | bash - \
    && apt-get update \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc \
    | gpg --dearmor -o /usr/share/keyrings/mongodb.gpg \
    && echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" \
    > /etc/apt/sources.list.d/mongodb-org-7.0.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends mongodb-mongosh \
    && rm -rf /var/lib/apt/lists/*

COPY package.json package-lock.json /opt/
COPY backend/package.json backend/package-lock.json /opt/backend/
COPY client/package.json client/package-lock.json /opt/client/

WORKDIR /opt/backend
RUN npm ci --omit=dev
WORKDIR /opt/client
RUN npm ci
WORKDIR /opt
RUN npm ci --omit=dev

COPY backend /opt/backend
COPY client /opt/client

# EXPOSE 3000 3001
CMD cd /opt && cat backend/create_mongo_user | mongosh "mongodb://${REACT_APP_MONGO_IP}:${REACT_APP_MONGO_PORT:-27017}" && npm start
