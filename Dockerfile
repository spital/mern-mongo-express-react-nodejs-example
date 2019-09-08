FROM ubuntu:18.04

RUN apt update
RUN apt -y install sudo gnupg wget
RUN sudo apt-get -y install curl
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
RUN sudo apt-get -y install nodejs gcc g++ make  # npm -v 6.10.2 node -v v12.8.0

RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
RUN echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
RUN apt update
RUN apt -y install mongodb-org-shell

COPY ./package* /opt/
COPY backend  /opt/backend
COPY client   /opt/client

WORKDIR /opt/backend
RUN npm install
WORKDIR /opt/client
RUN npm install
WORKDIR /opt
RUN npm install

# EXPOSE 3000
CMD cd /opt && cat backend/create_mongo_user | mongo 192.168.1.64 && npm start
