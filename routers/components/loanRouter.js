const express = require("express");
const router = express.Router();

router.get("/loans", (req, res) => res.send("You're welcome to loans page!"));

module.exports = router;
