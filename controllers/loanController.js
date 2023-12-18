const bcrypt = require("bcrypt");
const { sequelize } = require("../db");

//add new user
const addLoan = async (data) => {
  return await sequelize.models.Loans.create({
    amount: data.amount,
    interestRate: data.interestRate,
    durationMonths: data.durationMonths,
  });
};

module.exports = { addLoan };
