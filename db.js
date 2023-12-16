const { Sequelize } = require("sequelize");

let error = true;
count = 0;

const sequelize = new Sequelize(
  process.env.DB_NAME,
  process.env.DB_USERNAME,
  process.env.DB_PASSWORD,
  {
    host: process.env.HOST,
    dialect: "mysql",
    ssl: true,
    native: true,

    // Disable logging
    logging: false,
  }
);

let initiate = async () => {
  while (error && count < 5) {
    try {
      // const connection = await mysql.createConnection({ host: process.env.DB_HOST, user: process.env.DB_USERNAME, password: process.env.DB_PASSWORD, });
      // await connection.query(`CREATE DATABASE IF NOT EXISTS \`${process.env.DB_NAME}\`;`)
      // console.log(1)
      // verification de la connection

      await sequelize
        .authenticate()
        .then(() => {
          console.log("Connection has been established successfully.");
        })
        .catch((error) =>
          console.error("Unable to connect to the database:", error)
        );
      error = false;
      console.log({ error });
      console.log(">> Done\n");
    } catch (err) {
      console.log({ err });
      console.log({ error });
      error = true;
      console.log(`>> Retrying...${count + 1} retrie(s)`);
    }
    count++;
  }
};

module.exports = { sequelize, initiate };
