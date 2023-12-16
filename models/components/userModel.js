const { DataTypes } = require("sequelize");
const bcrypt = require("bcrypt");
const { generateToken, generateUID } = require("./../../helpers/helpers");

module.exports = (sequelize) => {
  const User = sequelize.define("Users", {
    id: {
      type: DataTypes.BIGINT,
      primaryKey: true,
      allowNull: false,
      unique: true,
      defaultValue: generateUID,
    },

    phone: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
    },

    lastname: {
      type: DataTypes.STRING,
      allowNull: false,
    },

    firstname: {
      type: DataTypes.STRING,
      allowNull: false,
    },

    password: {
      type: DataTypes.STRING,
      allowNull: false,
    },

    token: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: generateToken,
      unique: true,
    },
    // Add more attributes as needed
  });

  // Hook to hash the password and set user ID before creating or updating a user
  User.beforeCreate(async (user) => {
    // user.id = generateUID; // Modify this with your desired characters
    user.password = await bcrypt.hash(user.password, 10);

    // Set user ID as a combination of phone number and some characters

    // user.id = `${user.phone}${additionalCharacters}`;
  });

  return User;
};
