const express = require("express");
const app = express();
const router = express.Router();

router.get("/register", (req, res) =>
  res.send("You're welcome to registration page!")
);

module.exports = router;
