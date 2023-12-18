const { loanValidator } = require("./components/loanValidator");
const {
  loginValidator,
  registerValidator,
} = require("./components/userValidator");

module.exports = { loginValidator, registerValidator, loanValidator };
