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

module.exports = { checkUser, addUser, getUser };
