const { DataTypes } = require("sequelize");

module.exports = (sequelize) => {
  const Loans = sequelize.define("Loans", {
    id: {
      type: DataTypes.BIGINT,
      primaryKey: true,
      allowNull: false,
      unique: true,
      autoIncrement: true,
    },

    amount: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },

    interestRate: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },

    durationMonths: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
  });

  // Define association with Users model
  //   Loans.hasOne(sequelize.models.Users, {
  //     foreignKey: "userId",
  //     as: "Users",
  //     onDelete: "CASCADE",
  //   });
  Loans.associate = (models) => {
    Loans.belongsTo(models.Users, {
      foreignKey: "userId",
      onDelete: "CASCADE",
    });
  };

  return Loans;
};
