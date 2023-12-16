require("dotenv").config();
const express = require("express");
const app = express();

const router = require("./routers/router");

app.use("/", router);

app.get("/", (req, res) => res.send("Hello World!"));

app.listen(process.env.PORT, process.env.HOST, () =>
  console.log(`Server is running on ${process.env.HOST}:${process.env.PORT}!`)
);
