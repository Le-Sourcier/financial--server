const { sequelize } = require("../db");

const addLoan = async (data) => {
  // Check if the borrower (user) exists in the database
  const borrowerId = await sequelize.models.Users.findByPk(data.borrower_id);

  // If the borrower does not exist, return false
  if (!borrowerId) {
    return false;
  }

  // Create a new loan record in the Loans table
  return await sequelize.models.Loans.create({
    borrower_id: data.borrower_id, // Borrower identifier associated with the loan
    loan_amount: data.loan_amount, // Total amount of the loan
  });
};

module.exports = { addLoan };
