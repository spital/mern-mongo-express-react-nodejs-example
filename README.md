# React example full stack MongoDB, React, Node and Express (MERN) app

Original source from [Let’s build a full stack MongoDB, React, Node and Express (MERN) app](https://medium.com/javascript-in-plain-english/full-stack-mongodb-react-node-js-express-js-in-one-simple-app-6cc8ed6de274) and associated github.
Errors fixed, packages upgraded, vulnerabilities corrected, amended with Docker use.
TODO : use Docker Compose.

## Requirements
[Install Docker Engine](https://docs.docker.com/install/).
[Install Docker Compose](https://github.com/docker/compose/releases/latest).
[Install git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

## Build
Please note this is example development build.

```bash
git clone https://github.com/spital/mern-mongo-express-react-nodejs-example
cd mern-mongo-express-react-nodejs-example
( first edit IP address in secret.js - TODO pass var )
docker build -t ern-crud .
```

## Run

```bash
docker run -d -p 27017:27017  mongo:4-bionic
sleep 5
docker run -d -it -p3000:3000 -p3001:3001 ern-crud
```

## Use
Start web browser and go to (http://localhost:3000/).

The result shall be something like this :
![React example app screenshot](./learn_2019-09-08_20-44.png "React example app screenshot")

