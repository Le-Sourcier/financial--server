require("dotenv").config();
const express = require("express");
const app = express();
const cors = require("cors");
const bodyParser = require("body-parser");

app.use(cors()); //For Cross Origin Resource Sharing

app.use(bodyParser.json());

//#################
//Base de donnés et Models
require("./db")
  .initiate()
  .then(() => {
    try {
      require("./models/components/models").initModels();
    } catch (error) {
      console.log({ error });
    }
  });

const router = require("./routers/router");

app.use("/", router); //trigger all app routers

app.get("/", (req, res) => res.send("Hello World!"));

app.listen(process.env.PORT, process.env.HOST, () =>
  console.log(`Server is running on ${process.env.HOST}:${process.env.PORT}!`)
);
