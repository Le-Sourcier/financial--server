require("dotenv").config();

const userRouter = require("./components/userRoute");
const loanRouter = require("./components/loanRoute");
const adminRouter = require("./components/adminRoute");

const router = [userRouter, loanRouter, adminRouter];

module.exports = router;
