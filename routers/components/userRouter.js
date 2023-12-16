const express = require("express");
const { registerValidator } = require("../../validators/validators");
const router = express.Router();

const { serverMessage } = require("../../helpers/helpers");
const {
  checkUser,
  addUser,
  getUser,
} = require("../../controllers/userController");

//Registration router
router
  .post("/register", registerValidator, async (req, res, next) => {
    try {
      const data = req.body;

      // Check if user is already registred with this phone number
      let isExistUser = await checkUser(req.body);

      if (isExistUser) {
        const message = serverMessage("USER_EXIST");

        return res.status(401).json(message);
      }

      if (!data.phone) {
        const message = serverMessage("PHONE");

        return res.status(400).json(message);
      }

      if (!data.firstname) {
        const message = serverMessage("FIRST_NAME");

        return res.status(400).json(message);
      }

      if (!data.lastname) {
        const message = serverMessage("LAST_NAME");

        return res.status(400).json(message);
      }

      if (!data.password) {
        const message = serverMessage("NO_PASSWORD");

        return res.status(400).json(message);
      }

      //Add a new member to the database when there is no error
      const user = await addUser(data);

      if (!user) {
        const message = serverMessage("REGISTRATION_FAILD");
        return res.status(401).json(message);
      } else {
        //Get user
        const _ = await getUser(user); //get user by phone number ;

        let response = _?.toJSON();

        //Remove sensitive data from server responses
        delete response["password"];

        const message = serverMessage("REGISTRED", response);
        return res.status(200).json(message);
      }
    } catch (err) {
      const message = serverMessage("ERROR_SERVER");

      console.log(err); //Using in test mode

      return res.status(500).json(message);
    }
  })
  //Login router
  .get("/login", (req, res) => res.send("You're welcome to login page!"));

module.exports = router;
