const bcrypt = require("bcrypt");
const { sequelize } = require("../db");

//add new user
const addUser = async (data) => {
  return await sequelize.models.Users.create({
    firstname: data.firstname,
    lastname: data.lastname,
    phone: data.phone,
    password: data.password,
  });
};

//check an existante user
const checkUser = async ({ phone }) => {
  const users = await sequelize.models.Users.findAll({
    where: { phone: phone },
  });

  return users.length == 1;
};

//find user by phone number
const getUser = async (data) => {
  return await sequelize.models.Users.findOne({ where: { phone: data.phone } });
};

//find all registred user
const getAllUser = async () => {
  try {
    const users = await sequelize.models.Users.findAll();

    if (users && users.length > 0) {
      // Iterate through the array and remove sensitive data from each user
      const sanitizedUsers = users.map((user) => {
        const userJSON = user.toJSON();
        delete userJSON.password; // Remove sensitive data
        return userJSON;
      });

      return sanitizedUsers;
    } else {
      return [];
    }
  } catch (error) {
    return [];
  }
};

//Get user by id and token (for a security reason, it important to include user Token)
const getUserByIdAndTk = async (data) => {
  try {
    const user = await sequelize.models.Users.findByPk(data.id);

    if (user) {
      if (user.token !== data.token) {
        return false;
      } else {
        return user;
      }
    } else {
      return false;
    }
  } catch (error) {
    return false;
  }
};

//Delete user data from the data base
const deleteUser = async (data) => {
  const loanData = await sequelize.models.Loans.findOne({
    where: { account_id: data.id },
  });
  const allLoanData = await sequelize.models.Loans.findAll({
    where: { account_id: data.id },
  });
  // if(loanData.amount===)
  // return await sequelize.models.Users.destroy({
  //   where: { id: data.id, token: data.token },
  // });
};

//auth user with his known credentiales
const authUser = async ({ phone, password }) => {
  let user = await sequelize.models.Users.findOne({
    where: {
      phone: phone,
    },
  });

  if (user !== null) {
    if (bcrypt.compareSync(password, user.password)) {
      return user;
    } else {
      return "WRONG_PASSWORD";
    }
  } else {
    return false;
  }
};

module.exports = {
  checkUser,
  addUser,
  getUser,
  authUser,
  getUserByIdAndTk,
  deleteUser,
  getAllUser,
};
