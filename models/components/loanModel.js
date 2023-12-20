const { DataTypes } = require("sequelize");
const { generateUID } = require("../../helpers/helpers");

module.exports = (sequelize) => {
  // Define the Loans model
  const Loans = sequelize.define("Loans", {
    id: {
      type: DataTypes.BIGINT,
      primaryKey: true,
      allowNull: false,
      unique: true,
      defaultValue: generateUID,
    },

    // Identifier of the borrower associated with the loan
    borrower_id: {
      type: DataTypes.BIGINT,
      allowNull: false,
    },

    // The total amount of the loan
    loan_amount: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },

    // The amount of interest repaid for the loan,  initialized to 0
    interest_repaid: {
      type: DataTypes.FLOAT,
      allowNull: false,
      defaultValue: 0,
    },

    // The total amount repaid by the borrower, initialized to 0
    amount_repaid: {
      type: DataTypes.FLOAT,
      allowNull: false,
      defaultValue: 0,
    },

    // The duration of the loan in months (optional)
    // duration_months: {
    //   type: DataTypes.INTEGER,
    //   allowNull: true,
    // },
  });

  return Loans;
};

// const { DataTypes } = require("sequelize");
// const { generateUID } = require("../../helpers/helpers");

// module.exports = (sequelize) => {
//   const Loans = sequelize.define("Loans", {
//     id: {
//       type: DataTypes.BIGINT,
//       primaryKey: true,
//       allowNull: false,
//       unique: true,
//       defaultValue: generateUID,
//     },

//     borrower_id: {
//       type: DataTypes.BIGINT,
//       allowNull: false,
//     },

//     amount: {
//       type: DataTypes.FLOAT,
//       allowNull: false,
//     },

//     interestRate: {
//       type: DataTypes.FLOAT,
//       allowNull: false,
//     },

//     amountRepaid: {
//       type: DataTypes.FLOAT,
//       allowNull: false,
//       defaultValue: 0, // Amount initially repaid is 0
//     },

//     installmentAmount: {
//       type: DataTypes.FLOAT,
//       allowNull: false,
//     },

//     durationMonths: {
//       type: DataTypes.INTEGER,
//       allowNull: true,
//     },

//     // startDate: {
//     //   type: DataTypes.DATE,
//     //   allowNull: false,
//     // },

//     // endDate: {
//     //   type: DataTypes.DATE,
//     //   allowNull: true,
//     // },
//   });

//   return Loans;
// };
