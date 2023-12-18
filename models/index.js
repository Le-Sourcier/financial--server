const { sequelize } = require("../db");

//################################## USERS models ##################################
const UserModel = require("./components/userModel");
//################################## LOAN models ##################################
const loanModel = require("./components/loanModel");
//################################## ADMINS and MODERATORS models ##################################
const adminModel = require("./components/adminModel");

//############################## MODEL Initialization #############################
const initModels = () => {
  //init models
  UserModel(sequelize);
  loanModel(sequelize);
  adminModel(sequelize);

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
