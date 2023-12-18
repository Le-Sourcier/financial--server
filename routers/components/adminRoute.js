const express = require("express");
const { registerValidator, loginValidator } = require("../../validators");

const router = express.Router();

const { serverMessage } = require("../../helpers/helpers");

const { getAllUser, checkUser } = require("../../controllers/userController");

const { sequelize } = require("../../db");
const { Sequelize } = require("sequelize");

const {
  checkAdmin,
  addNewAdmin,
  getAdmin,
  getAminByIdAndTk,
  deleteAmin,
  authAdmin,
  promoteToAdminOrModerator,
  promoteModeratorToAdmin,
  revokeModerator,
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
      let isAdminExist = await checkAdmin(req.body);
      let isUserExist = await checkUser(req.body);

      if (isAdminExist || isUserExist) {
        const message = serverMessage("PHONE_EXIST");

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
  //Promote moderator to admin
  .post("/promote/:token", async (req, res, next) => {
    //Get the admin token
    const token = req.params.token;
    //Get user ID
    const m_id = req.body.m_id;
    //Get promotion status (MODERATOR or ADMIN)
    const status = req.body.status;
    //Get admin id
    const id = req.body.id;

    try {
      if (!token || !m_id || !status || !id) {
        const message = serverMessage("NOT_AUTHORIZED");
        return res.status(401).json(message);
      }
      //check if it's admin
      const admin = await getAminByIdAndTk({ id, token });

      if (!admin) {
        const message = serverMessage("ACCESS_DENIED");
        return res.status(401).json(message);
      }

      const promoteUser = await promoteModeratorToAdmin({ m_id });
      if (!promoteUser) {
        return res.status(401).json({
          error: true,
          status: 401,
          message: "ERROR_IN MODERATOR_PROMOTION",
          data: [],
        });
      } else {
        const message = serverMessage("SUCCESS");
        return res.status(200).json(message);
      }
    } catch (error) {
      const message = serverMessage("ERROR_SERVER");
      console.log("Error in promoting moderator : ", error);
      return res.status(200).json(message);
    }
  })
  //Revoke moderator
  .post("/revoke/:token", async (req, res, next) => {
    const token = req.params.token; //Admin token
    const id = req.body.id; //Admin ID
    const { m_id } = req.body; //Moderator ID
    try {
      if (!token || !id || !m_id) {
      }
      const isAdmin = await getAminByIdAndTk({ id, token });
      if (!isAdmin) {
        const message = serverMessage("ACCESS_DENIED");
        return res.status(401).json(message);
      }
      const isVevoked = await revokeModerator({ m_id });
      if (!isVevoked) {
        const message = serverMessage("REVOCATION_FAILED");
        return res.status(401).json(message);
      }
      const message = serverMessage("REVOKED");

      return res.status(200).json(message);
    } catch (error) {}
  })
  //Promote user to admin or moderator
  .post("/promote/:token", async (req, res, next) => {
    //Get the admin token
    const token = req.params.token;
    //Get user ID
    const u_id = req.body.u_id;
    //Get promotion status (MODERATOR or ADMIN)
    const status = req.body.status;
    //Get admin id
    const id = req.body.id;

    console.log(status);

    try {
      if (!token || !u_id || !status || !id) {
        const message = serverMessage("NOT_AUTHORIZED");
        return res.status(401).json(message);
      }
      //check if it's admin
      const admin = await getAminByIdAndTk({ id, token });

      if (!admin) {
        const message = serverMessage("ACCESS_DENIED");
        return res.status(401).json(message);
      }
      const promoteUser = await promoteToAdminOrModerator({ u_id, status });
      if (!promoteUser) {
        const message = serverMessage("PROMOTION_ERROR");
        return res.status(401).json(message);
      } else {
        const message = serverMessage("PROMOTED");
        return res.status(200).json(message);
      }
    } catch (error) {
      const message = serverMessage("ERROR_SERVER");
      console.log("Error in promoting user : ", error);
      return res.status(200).json(message);
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

      const admin = await getAminByIdAndTk({ id, token });

      if (!admin) {
        const message = serverMessage("ACCESS_DENIED");
        return res.status(401).json(message);
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
