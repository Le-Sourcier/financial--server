require("dotenv").config();

const userRouter = require("./components/userRoute");
const loanRouter = require("./components/loanRoute");
const adminRouter = require("./components/adminRoute");
const customerRoute = require("./components/customerRoute");

const router = [userRouter, loanRouter, adminRouter, customerRoute];

module.exports = router;
