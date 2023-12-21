const { sequelize } = require("../db");

const transaction = async (data) => {
  // Check if the borrower (user or the customer) exists in the database
  const accountId = await sequelize.models.Users.findByPk(data.account_id);
  const customerId = await sequelize.models.Customer.findByPk(data.account_id);
  const adminId = await sequelize.models.Admins.findByPk(data.account_id);

  // If the borrower does not exist, return false
  if (!accountId || !customerId) {
    return false;
  }

  // Create a new loan record in the Loans table
  return await sequelize.models.Trans.create({
    account_id: data.account_id, // Borrower identifier associated with the loan
    amount: data.amount, // Total amount of the loan
    operation: data.operation,
  });
};

module.exports = { transaction };
