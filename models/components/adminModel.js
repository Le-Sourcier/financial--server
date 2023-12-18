const { DataTypes } = require("sequelize");
const bcrypt = require("bcrypt");
const { generateToken, generateUID } = require("./../../helpers/helpers");

module.exports = (sequelize) => {
  const Admins = sequelize.define("Admins", {
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

    status: {
      type: DataTypes.ENUM,
      defaultValue: "SUPER_ADMIN",
      allowNull: false,
      values: ["SUPER_ADMIN", "ADMIN", "MODERATOR"],
    },
  });

  // Hook to hash the password and set user ID before creating or updating a user
  Admins.beforeCreate(async (admin) => {
    admin.password = await bcrypt.hash(admin.password, 10);
  });

  return Admins;
};
