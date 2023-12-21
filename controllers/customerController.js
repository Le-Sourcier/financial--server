const bcrypt = require("bcrypt");
const { sequelize } = require("../db");

//add new Customer
const addCustomer = async (data) => {
  return await sequelize.models.Customers.create({
    firstname: data.firstname,
    lastname: data.lastname,
    phone: data.phone,
    witness_id: data.id,
  });
};

//check an existante Customer
const checkCustomer = async ({ phone }) => {
  const customers = await sequelize.models.Customers.findAll({
    where: { phone: phone },
  });

  return customers.length == 1;
};

//find Customer by phone number
const getCustomer = async (data) => {
  return await sequelize.models.Customers.findOne({
    where: { phone: data.phone },
  });
};

//find all registred Customer
const getAllCustomer = async () => {
  try {
    const customers = await sequelize.models.Customers.findAll();

    if (customers && customers.length > 0) {
      return customers;
    } else {
      return [];
    }
  } catch (error) {
    return [];
  }
};

//Get Customer by id and token (for a security reason, it important to include Customer Token)
const getCustomerByIdAndTk = async (data) => {
  try {
    const customer = await sequelize.models.Customers.findByPk(data.id);

    if (customer) {
      if (customer.token !== data.token) {
        return false;
      } else {
        return customer;
      }
    } else {
      return false;
    }
  } catch (error) {
    return false;
  }
};

//Delete Customer data from the data base
const deleteCustomer = async (data) => {
  const loanData = await sequelize.models.Loans.findOne({
    where: { account_id: data.id },
  });
  const allLoanData = await sequelize.models.Loans.findAll({
    where: { account_id: data.id },
  });
  // if(loanData.amount===)
  // return await sequelize.models.Customers.destroy({
  //   where: { id: data.id, token: data.token },
  // });
};

module.exports = {
  checkCustomer,
  addCustomer,
  getCustomer,
  getCustomerByIdAndTk,
  deleteCustomer,
  getAllCustomer,
};
