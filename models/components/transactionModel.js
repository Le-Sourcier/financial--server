const { DataTypes } = require("sequelize");
const { generateUID } = require("../../helpers/helpers");

module.exports = (sequelize) => {
  // Define the Loans model
  const Trans = sequelize.define("Transactions", {
    id: {
      type: DataTypes.BIGINT,
      primaryKey: true,
      allowNull: false,
      unique: true,
      defaultValue: generateUID,
    },

    // Identifier of the user associated with the transaction
    account_id: {
      type: DataTypes.BIGINT,
      allowNull: false,
    },

    // Amount added or deducted in the transaction
    amount: {
      type: DataTypes.FLOAT,
      allowNull: false,
      defaultValue: 0.0,
    },

    // Type of transaction operation
    operation: {
      type: DataTypes.ENUM,
      allowNull: false,
      defaultValue: "CREDITED",
      values: ["CREDITED", "DEBITED", "BORROWED", "REPAID"],
    },
  });

  return Trans;
};
