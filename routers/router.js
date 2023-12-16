require("dotenv").config();

const userRouter = require("./components/userRouter");
const loanRouter = require("./components/loanRouter");

const router = [userRouter, loanRouter];

module.exports = router;
