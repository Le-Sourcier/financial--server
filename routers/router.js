require("dotenv").config();

const userRouter = require("./components/userRouter");
const loanRouter = require("./components/loansRouter");

const router = [userRouter, loanRouter];

module.exports = router;
