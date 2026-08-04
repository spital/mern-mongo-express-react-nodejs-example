const mongoose = require("mongoose");
const getSecret = require("./secret");
const express = require("express");
const cors = require("cors");
const logger = require("morgan");
const Data = require("./data");

const API_PORT = 3001;
const app = express();
app.use(cors());
const router = express.Router();

mongoose.set("strictQuery", true);
mongoose.connect(getSecret("dbUri"));
let db = mongoose.connection;
db.once("open", () => console.log("connected to the database"));

db.on("error", console.error.bind(console, "MongoDB connection error:"));

app.use(express.urlencoded({ extended: false, limit: "10kb" }));
app.use(express.json({ limit: "10kb" }));
app.use(logger("dev"));

router.get("/", (req, res) => {
  res.json({ message: "HELLOW WORLDUUHHHH" });
});

router.get("/getData", (req, res) => {
  //console.warn("get: req.body %j",req.body);
  Data.find((err, data) => {
    if (err) return res.json({ success: false, error: err });
    //console.warn("get ret: data %j",data);
    return res.json({ success: true, data: data });
  });
});

router.post("/updateData", (req, res) => {
  const { id, update } = req.body;
  //console.warn("upd: req %j",req.body);
  //console.warn(`upd: id ${id} upd ${update}`);
  if (update === null || typeof update !== "object" || typeof update.message !== "string") {
    return res.status(400).json({ success: false, error: "INVALID UPDATE" });
  }
  Data.findOneAndUpdate({ id }, { message: update.message }, { upsert: true }, (err) => {
    if (err) return res.json({ success: false, error: err });
    return res.json({ success: true });
  });
});

router.delete("/deleteData", (req, res) => {
  const { id } = req.body;
  //console.warn("del req.body : %j", req.body)
  //console.warn(`del: id ${id} `);
  Data.findOneAndRemove({'id':id}, (err) => {
    if (err) return res.send(err);
    return res.json({ success: true });
  });
});

router.post("/putData", (req, res) => {
  let data = new Data();

  const { id, message } = req.body;
  // console.warn(`put: id ${id} msg ${message}`);
  if ((!id && id !== 0) || !message) {
    return res.json({
      success: false,
      error: "INVALID INPUTS"
    });
  }
  data.message = message;
  data.id = id;
  data.save((err) => {
    if (err) return res.json({ success: false, error: err });
    return res.json({ success: true });
  });
});

app.use("/api", router);

app.listen(API_PORT, () => console.log(`LISTENING ON UHH PORT ${API_PORT}`));
