
//let dbUri = `mongodb://myUser:MySecretPassword@${process.env.REACT_APP_MONGO_IP}:${process.env.REACT_APP_MONGO_PORT}/mydb`

const secrets = {
  // dbUri: "mongodb://jelo:a9bc839993@ds151382.mlab.com:51382/jelotest"
  // dbUri: dbUri
  dbUri: `mongodb://myUser:MySecretPassword@${process.env.REACT_APP_MONGO_IP}:${process.env.REACT_APP_MONGO_PORT}/mydb`
};

const getSecret = key => secrets[key];

module.exports = getSecret;
