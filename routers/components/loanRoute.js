const express = require("express");

const router = express.Router();

// const { serverMessage } = require("../../helpers/helpers");

const { addLoan } = require("../../controllers/loanController");
const { sequelize } = require("../../db");
const { loanValidator } = require("../../validators");

//Registration router
router
  .post("/loans", loanValidator, async (req, res, next) => {
    const data = req.body;
    try {
      const newLoan = await addLoan(data);
      return res.status(201).json(newLoan);
    } catch (error) {
      console.error(error);
      return res.status(500).json({ error: "Internal Server Error" });
    }
  }) // Get all loans
  .get("/loans", async (req, res) => {
    try {
      const loans = await sequelize.models.Loans.findAll();
      return res.status(200).json(loans);
    } catch (error) {
      console.error(error);
      return res.status(500).json({ error: "Internal Server Error" });
    }
  });

module.exports = router;
