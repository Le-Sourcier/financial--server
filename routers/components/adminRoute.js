const express = require("express");
const { registerValidator, loginValidator } = require("../../validators");

const router = express.Router();

const { serverMessage } = require("../../helpers/helpers");

const { getAllUser } = require("../../controllers/userController");

const { sequelize } = require("../../db");
const { Sequelize } = require("sequelize");

const {
  checkAdmin,
  addNewAdmin,
  getAdmin,
  getAminByIdAndTk,
  deleteAmin,
  authAdmin,
} = require("../../controllers/adminController");

//Admin registration router
router
  .post("/add-admin", registerValidator, async (req, res, next) => {
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

      if (!data.password) {
        const message = serverMessage("NO_PASSWORD");

        return res.status(400).json(message);
      }

      // Check if admin is already registred with this phone number
      let isExistUser = await checkAdmin(req.body);

      if (isExistUser) {
        const message = serverMessage("ADMIN_EXIST");

        return res.status(401).json(message);
      }

      //Add a new member to the database when there is no error
      const user = await addNewAdmin(data);

      if (!user) {
        const message = serverMessage("REGISTRATION_FAILD");
        return res.status(401).json(message);
      } else {
        //Get admin
        const _ = await getAdmin(user); //get admin by phone number ;

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
  //Admin login router
  .post("/login", loginValidator, async (req, res, next) => {
    const data = req.body;
    try {
      if (!data.phone) {
        const message = serverMessage("PHONE");

        return res.status(400).json(message);
      }

      if (!data.password) {
        const message = serverMessage("NO_PASSWORD");

        return res.status(400).json(message);
      }

      //Authenticate the user with their credentials (such as phone password)
      const result = await authAdmin(data);

      if (!result) {
        const message = serverMessage("AUTH_FAILED");
        return res.status(417).json(message);
      } else if (result === "WRONG_PASSWORD") {
        const message = serverMessage("WRONG_PASSWORD");

        return res.status(406).json(message);
      } else {
        let response = result?.toJSON();

        //Remove sensitive data from server responses
        delete response["password"];

        const message = serverMessage("LOGIN", response);
        return res.status(200).json(message);
      }
    } catch (err) {
      const message = serverMessage("ERROR_SERVER");

      console.log(err); //Using in test mode

      return res.status(500).json(message);
    }
  })
  //delete admin or moderator
  .delete("/delete/:token", async (req, res, next) => {
    const token = req.params.token;
    const id = req.body.id;

    try {
      if (!token || !id) {
        const message = serverMessage("NOT_AUTHORIZED");
        return res.status(401).json(message);
      }

      const user = await getAminByIdAndTk({ id, token });

      if (!user) {
        const message = serverMessage("AUTH_FAILED");
        return res.status(417).json(message);
      }

      const _ = await deleteAmin({ id, token });

      if (!_) {
        const message = serverMessage("FAILED_DELETTION");
        return res.status(417).json(message);
      }

      const message = serverMessage("DELETED");
      return res.status(200).json(message);
    } catch (error) {
      console.log(error);
      const message = serverMessage("ERROR_SERVER");
      return res.status(500).json(message);
    }
  })
  //Get all user
  .get("/users/:token", async (req, res, next) => {
    const token = req.params.token;
    const id = req.body.id;
    try {
      if (!id || !token) {
        const message = serverMessage("NOT_AUTHORIZED");
        return res.status(401).json(message);
      }

      //Check if it's admin or not (show true or false otherwise)
      const isAdmin = await getAminByIdAndTk({ id, token });
      if (!isAdmin) {
        const message = serverMessage("ACCESS_DENIED");
        return res.status(401).json(message);
      }
      //Get all database recorded users
      const allUser = await getAllUser();

      const message = serverMessage("AUTHORIZED", allUser);
      return res.status(200).json(message);
    } catch (error) {
      const message = serverMessage("ERROR_SERVER");
      console.log(error);
      return res.status(401).json(message);
    }
  })

  .post("/createTable", async (req, res) => {
    const { tableName, columns } = req.body;

    try {
      // Map custom data types to Sequelize-specific data types
      const mappedColumns = Object.entries(columns).reduce(
        (acc, [key, value]) => {
          const sequelizeType = Sequelize[value.type];
          if (sequelizeType) {
            acc[key] = {
              type: sequelizeType,
            };
          }
          return acc;
        },
        {}
      );

      // Define the dynamic table model
      const dynamicTable = sequelize.define(tableName, mappedColumns);

      // Create the table in the database
      await dynamicTable.sync();

      res
        .status(201)
        .json({ message: `Table ${tableName} created successfully.` });
    } catch (error) {
      console.error(error);
      res
        .status(500)
        .json({ error: "An error occurred while creating the table." });
    }
  });

module.exports = router;