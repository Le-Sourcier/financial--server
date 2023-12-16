const Joi = require("joi");

const registerValidator = async (req, res, next) => {
  try {
    await Joi.object({
      phone: Joi.number().required(),
      lastname: Joi.string().required(),
      firstname: Joi.string().required(),
      address: Joi.string().required(),
    }).validateAsync(req.body);
    return next();
  } catch (error) {
    console.log("error in registervalidator");
    return next(error);
  }
};

const loginValidator = async (req, res, next) => {
  try {
    await Joi.object({
      phone: Joi.string().required().email().rule({
        message: "phone Invalid",
      }),
      password: Joi.string().required(),
    }).validateAsync(req.body);
    return next();
  } catch (error) {
    console.log("error in loginvalidator");
    return next(error);
  }
};

module.exports = { loginValidator, registerValidator };
