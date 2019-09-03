const secrets = {
  // dbUri: "mongodb://jelo:a9bc839993@ds151382.mlab.com:51382/jelotest"
  dbUri: "mongodb://localhost:27017/mydb"
};

const getSecret = key => secrets[key];

module.exports = getSecret;
