const { sequelize } = require("../db");

const addLoan = async (data) => {
  // Check if the borrower (user) exists in the database
  const userId = await sequelize.models.Users.findByPk(data.account_id);

  // Check if the borrower (customer) exists in the database
  const customerId = await sequelize.models.Customers.findOne({
    where: { phone: data.phone },
  });

  // If the borrower exist, record data into the database
  if (userId || customerId) {
    // Create a new loan record in the Loans table
    return await sequelize.models.Loans.create({
      account_id: data.account_id, // Borrower identifier associated with the loan
      loan_amount: data.loan_amount, // Total amount of the loan
    });
  } else {
    return false; //return false if user or custmer does not exist
  }
};

module.exports = { addLoan };
