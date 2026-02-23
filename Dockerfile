FROM ubuntu:22.04

RUN apt update
RUN apt -y install sudo gnupg wget
RUN sudo apt-get -y install curl
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
RUN sudo apt-get -y install nodejs gcc g++ make  # npm -v 6.10.2 node -v v12.8.0



RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4

RUN wget -qO - https://www.mongodb.org/static/pgp/server-7.0.asc |  gpg --dearmor | sudo tee /usr/share/keyrings/mongodb.gpg > /dev/null
RUN echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
RUN sudo apt update
RUN sudo apt -y install mongodb-org

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
CMD cd /opt && cat backend/create_mongo_user | mongosh $REACT_APP_MONGO_IP && npm start
