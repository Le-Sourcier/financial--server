const { DataTypes } = require("sequelize");
const { generateToken, generateUID } = require("./../../helpers/helpers");

module.exports = (sequelize) => {
  const Customers = sequelize.define("Customers", {
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

    image: {
      type: DataTypes.STRING,
      allowNull: true,
    },

    // The ID of a member who acts as a witness
    // This is in case of non-payment by the non-member client,
    // The member client will undertake to pay the amount owed by their protegé
    witness_id: {
      type: DataTypes.BIGINT,
      allowNull: true,
    },

    token: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: generateToken,
      unique: true,
    },
  });

  return Customers;
};
