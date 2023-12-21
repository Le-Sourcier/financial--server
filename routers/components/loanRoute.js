const express = require("express");

const router = express.Router();

// const { serverMessage } = require("../../helpers/helpers");

const { addLoan } = require("../../controllers/loanController");
const { sequelize } = require("../../db");
const { loanValidator } = require("../../validators");
const { serverMessage } = require("../../helpers/helpers");

const moment = require("moment");

//Registration router
router
  .post("/loans", loanValidator, async (req, res, next) => {
    const { id, amount } = req.body;
    try {
      // Get the current date
      const month = 12 - moment().month();

      if (!id) {
        const message = serverMessage("ACCESS_DENIED");
        return res.status(401).json(message);
      }
      if (!amount) {
        const message = serverMessage("EMPTY_FIELD");
        return res.status(400).json(message);
      }

      // if (month < 6) {
      //   const message = serverMessage("REQUEST_LOAN");
      //   return res.status(401).json(message);
      // }

      const isAdmin = await sequelize.models.Admins.findByPk(id);
      console.log("Admin", isAdmin);
      if (!isAdmin) {
        const message = serverMessage("NOT_AUTHORIZED");
        return res.status(401).json(message);
      }
      const data = {
        account_id: req.body.account_id,
        loan_amount: amount,
        phone: req.body.phone,
      };

      const newLoan = await addLoan(data);
      if (!newLoan) {
        const message = serverMessage("ERROR_LOAN");
        return res.status(401).json(message);
      }
      const message = serverMessage("LOAN_ADDED", newLoan);
      return res.status(201).json(message);
    } catch (error) {
      console.error(error);
      const message = serverMessage("ERROR_SERVER");
      return res.status(500).json(message);
    }
  }) // Get all loans
  .get("/loans", async (req, res) => {
    try {
      let loans;
      if (!req.body.id) {
        const message = serverMessage("ACCESS_DENIED");
        return res.status(401).json(message);
      }
      const isAdmin = await sequelize.models.Admins.findByPk(req.body.id);
      const isMember = await sequelize.models.Users.findByPk(req.body.id);
      const isCustomer = await sequelize.models.Loans.findOne({
        where: { account_id: req.body.id },
      });

      if (isAdmin) {
        loans = await sequelize.models.Loans.findAll();
      } else if (isMember) {
        loans = await sequelize.models.Loans.findAll({
          where: { account_id: isMember.id },
        });
      } else if (isCustomer) {
        loans = await sequelize.models.Loans.findAll({
          where: { account_id: isCustomer.account_id },
        });
      } else {
        const message = serverMessage("NOT_AUTHORIZED");
        return res.status(401).json(message);
      }

      if (!loans || loans.length === 0) {
        return res.status(404).json({
          error: true,
          status: 404,
          message: isAdmin
            ? "NO_LOANS_FOUND"
            : "NO_LOANS_ASSOCIATED_WITH_ACCOUNT",
          data: [],
        });
      }

      //  // Retrieve all loan data for a specific client
      //  const allLoanData = await sequelize.models.Loans.findAll({
      //   where: { account_id: req.body.id },
      // });

      // // Calculate the total loan amount borrowed by the client
      // const totalLoanAmount = allLoanData.reduce(
      //   (accumulator, loan) => accumulator + loan.loan_amount,
      //   0
      // );

      // console.log("total Loan Amount : ", totalLoanAmount);

      // if()
      const message = serverMessage("SUCCESS", loans);
      return res.status(200).json(message);
    } catch (error) {
      console.error(error);
      const message = serverMessage("ERROR_SERVER");
      return res.status(500).json(message);
    }
  });

module.exports = router;
