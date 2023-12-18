const bcrypt = require("bcrypt");
const { sequelize } = require("../db");

//add new user
const addNewAdmin = async (data) => {
  return await sequelize.models.Admins.create({
    firstname: data.firstname,
    lastname: data.lastname,
    phone: data.phone,
    password: data.password,
  });
};

//check an existante user
const checkAdmin = async ({ phone }) => {
  const admins = await sequelize.models.Admins.findAll({
    where: { phone: phone },
  });

  return admins.length == 1;
};

//find admin by phone number
const getAdmin = async (data) => {
  return await sequelize.models.Admins.findOne({
    where: { phone: data.phone },
  });
};

//Get admin by id and token (for a security reason, it important to include user Token)
const getAminByIdAndTk = async (data) => {
  try {
    const admin = await sequelize.models.Admins.findByPk(data.id);

    if (admin) {
      if (admin.token !== data.token) {
        return false;
      } else {
        return admin;
      }
    } else {
      return false;
    }
  } catch (error) {
    return false;
  }
};

//Promte admin as admin
const promoteAdmin = async (data) => {
  try {
  } catch (error) {}
};

//Promte user as moderator
const promoteModerator = async () => {};

//revoke as moderator title
const revokeModerator = async (data) => {
  try {
    // Validate user credentials and check if the user is a moderator
    const moderator = await sequelize.models.Admins.findOne({
      where: { id: data.id, token: data.token, status: "MODERATOR" },
    });

    if (moderator) {
      // Ensure the ID and token are valid before proceeding with the deletion
      const isValidIdAndToken = await sequelize.models.Admins.findOne({
        where: { id: moderator.id, token: moderator.token },
      });

      if (isValidIdAndToken) {
        // Check if the user already exists in the Users table
        const existingUser = await sequelize.models.Users.findOne({
          where: { id: moderator.id },
        });

        if (existingUser) {
          // User already exists in the Users table
          return false;
        }

        // Transfer moderator data to the Users table
        await sequelize.models.Users.create({
          id: moderator.id,
          token: moderator.token,
          phone: moderator.phone,
          lastname: moderator.lastname,
          firstname: moderator.firstname,
          password: moderator.password,
        });

        // Revoke moderator status by deleting the user record from the Admins table
        await sequelize.models.Admins.destroy({
          where: { id: moderator.id, token: moderator.token },
        });

        return true; // Successfully transferred and revoked moderator status
      } else {
        return false; // Invalid ID or token
      }
    } else {
      return false; // User is not a moderator or credentials are invalid
    }
  } catch (error) {
    console.error("Error in revokeModerator:", error);
    return false; // An error occurred during the operation
  }
};

//Revoke admin title
const revokeAdmin = async (data) => {
  try {
    // Validate user credentials and check if the user is a admin
    const admin = await sequelize.models.Admins.findOne({
      where: { id: data.id, token: data.token, status: "ADMIN" },
    });

    if (admin) {
      // Ensure the ID and token are valid before proceeding with the deletion
      const isValidIdAndToken = await sequelize.models.Admins.findOne({
        where: { id: admin.id, token: admin.token },
      });

      if (isValidIdAndToken) {
        // Check if the user already exists in the Users table
        const existingUser = await sequelize.models.Users.findOne({
          where: { id: admin.id },
        });

        if (existingUser) {
          // User already exists in the Users table
          return false;
        }

        // Transfer admin data to the Users table
        await sequelize.models.Users.create({
          id: admin.id,
          token: admin.token,
          phone: admin.phone,
          lastname: admin.lastname,
          firstname: admin.firstname,
          password: admin.password,
        });

        // Revoke admin status by deleting the user record from the Admins table
        await sequelize.models.Admins.destroy({
          where: { id: admin.id, token: admin.token },
        });

        return true; // Successfully transferred and revoked admin status
      } else {
        return false; // Invalid ID or token
      }
    } else {
      return false; // User is not a admin or credentials are invalid
    }
  } catch (error) {
    console.error("Error in revokeModerator:", error);
    return false; // An error occurred during the operation
  }
};
//Delete admin data from the data base
const deleteAmin = async (data) => {
  return await sequelize.models.Admins.destroy({
    where: { id: data.id, token: data.token },
  });
};

//auth admin with his known credentiales
const authAdmin = async ({ phone, password }) => {
  let admin = await sequelize.models.Admins.findOne({
    where: {
      phone: phone,
    },
  });

  if (admin !== null) {
    if (bcrypt.compareSync(password, admin.password)) {
      return admin;
    } else {
      return "WRONG_PASSWORD";
    }
  } else {
    return false;
  }
};

module.exports = {
  checkAdmin,
  addNewAdmin,
  getAdmin,
  authAdmin,
  getAminByIdAndTk,
  deleteAmin,
  revokeAdmin,
  promoteAdmin,
  promoteModerator,
  revokeModerator,
};
