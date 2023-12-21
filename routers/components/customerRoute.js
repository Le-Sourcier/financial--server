const express = require("express");
const router = express.Router();

const { serverMessage } = require("../../helpers/helpers");
const {
  checkCustomer,
  addCustomer,
  getCustomer,
  getCustomerByIdAndTk,
  deleteCustomer,
} = require("../../controllers/customerController");

const { checkAdmin } = require("../../controllers/adminController");

//Registration router
router
  .post("/register", async (req, res, next) => {
    try {
      const data = req.body;

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

      // Check if customer is already registred with this phone number
      let isCustomerExist = await checkCustomer(req.body);
      let isDataExist = await checkAdmin(req.body);

      if (isCustomerExist || isDataExist) {
        const message = serverMessage("PHONE_EXIST");

        return res.status(401).json(message);
      }

      //Add a new customer to the database when there is no error
      const customer = await addCustomer(data);

      if (!customer) {
        const message = serverMessage("REGISTRATION_FAILD");
        return res.status(401).json(message);
      } else {
        //Get customer
        const _ = await getCustomer(customer); //get customer by phone number ;

        const message = serverMessage("REGISTRED", _);
        return res.status(200).json(message);
      }
    } catch (err) {
      const message = serverMessage("ERROR_SERVER");

      console.log(err); //Using in test mode

      return res.status(500).json(message);
    }
  })

  .delete("/delete/:token", async (req, res, next) => {
    const token = req.params.token;
    const id = req.body.id;

    try {
      if (!token || !id) {
        const message = serverMessage("ACCESS_DENIED");
        return res.status(401).json(message);
      }

      const customer = await getCustomerByIdAndTk({ id, token });

      if (!customer) {
        const message = serverMessage("NOT_AUTHORIZED");
        return res.status(417).json(message);
      }

      const _ = await deleteCustomer({ id, token });

      if (!_) {
        const message = serverMessage("FAILED_DELETTION");
        return res.status(417).json(message);
      }

      const message = serverMessage("DELETED");
      return res.status(200).json(message);
    } catch (error) {
      // console.log(error);
      const message = serverMessage("ERROR_SERVER");
      return res.status(500).json(message);
    }
  });

module.exports = router;
