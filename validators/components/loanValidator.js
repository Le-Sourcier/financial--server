const Joi = require("joi");

const loanSchema = Joi.object({
  amount: Joi.number().positive().required(),
  interestRate: Joi.number().positive().required(),
  durationMonths: Joi.number().integer().positive().required(),
});

const loanValidator = async (req, res, next) => {
  try {
    await loanSchema
      .unknown(true) // This will disallow any additional fields
      .validateAsync(req.body);
    return next();
  } catch (error) {
    return res.status(400).json({ error: error.details[0].message });
  }
};

module.exports = { loanValidator };
