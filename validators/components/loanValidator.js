const Joi = require("joi");

const loanSchema = Joi.object({
  id: Joi.number().positive().required(),
  amount: Joi.number().positive().required(),
});

const loanValidator = async (req, res, next) => {
  try {
    await loanSchema
      .unknown(true) // This will disallow any additional fields
      .validateAsync(req.body);
    return next();
  } catch (error) {
    // return res.status(400).json({ error: error.details[0].message });
    return next();
  }
};

module.exports = { loanValidator };
