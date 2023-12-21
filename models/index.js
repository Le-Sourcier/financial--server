const { sequelize } = require("../db");

//################################## USERS models ##################################
const userModel = require("./components/userModel");
//################################## USERS models ##################################
const customerModel = require("./components/customerModel");
//################################## LOAN models ##################################
const loanModel = require("./components/loanModel");
//################################## TRANSACTION models ##################################
const transactionModel = require("./components/transactionModel");
//################################## ADMINS and MODERATORS models ##################################
const adminModel = require("./components/adminModel");

//############################## MODEL Initialization #############################
const initModels = () => {
  //init models
  userModel(sequelize);
  customerModel(sequelize);
  loanModel(sequelize);
  adminModel(sequelize);
  transactionModel(sequelize);

  //Data base init
  sequelize
    .sync({ force: false })
    .then((seccess) => {
      console.log(">> The database was initialized successfully!");
    })
    .catch((error) => {
      console.log(error);
      console.log(">> Database initialization failed!");
    });
};

//################################## EXPORT MODELS ################################
module.exports = { initModels };
