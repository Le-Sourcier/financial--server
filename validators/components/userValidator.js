const Joi = require("joi");

const registerValidator = async (req, res, next) => {
  try {
    await Joi.object({
      phone: Joi.string().required(),
      lastname: Joi.string().required(),
      firstname: Joi.string().required(),
      password: Joi.string().required(),
      // address: Joi.string().required(),
    })
      .unknown(true) // This will disallow any additional fields
      .validateAsync(req.body);
    return next();
  } catch (error) {
    console.log("error in registervalidator");
    return next();
    // return;
  }
};

const loginValidator = async (req, res, next) => {
  try {
    await Joi.object({
      phone: Joi.string().required(),
      password: Joi.string().required(),
    })
      .unknown(true) // This will disallow any additional fields
      .validateAsync(req.body);
    return next();
  } catch (error) {
    console.log("error in loginvalidator");
    return next();
  }
};

module.exports = { loginValidator, registerValidator };
