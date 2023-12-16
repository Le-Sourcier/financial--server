const serverMessage = (key, data = []) => {
  let error = false;
  let message;
  let status = 500;

  switch (key) {
    case "PHONE":
      error = true;
      status = 400;
      message = "MISSING_PHONE_NUMBER";
      break;

    case "FIRST_NAME":
      error = true;
      status = 400;
      message = "MISSING_FIRST_NAME";
      break;

    case "LAST_NAME":
      error = true;
      status = 400;
      message = "MISSING_LAST_NAME";
      break;

    case "NO_PASSWORD":
      error = true;
      status = 400;
      message = "MISSING_PASSWORD";
      break;

    case "USER_EXIST":
      error = true;
      status = 401;
      message = "USER_ALREADY_EXIST";
      break;

    case "REGISTRATION_FAILD":
      error = true;
      status = 401;
      message = "USER_REGISTRATION_FAILD";
      break;

    case "REGISTRED":
      error = false;
      status = 200;
      message = "SUCESSFYLLY_REGISTRED";
      break;

    case "ERROR_SERVER":
    default:
      error = true;
      status = status;
      message = "INTERNAL_SERVER_ERROR";
      break;
  }

  return { error, status, message, data };
};

module.exports = { serverMessage };
