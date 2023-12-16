const { sequelize } = require("../../db");

//################################## USERS models ##################################
const UserModel = require("./userModel");

//############################## MODEL Initialization #############################
const initModels = () => {
  //User models
  UserModel(sequelize);

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
