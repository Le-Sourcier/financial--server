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

    case "EMPTY_FIELD":
      error = true;
      status = 400;
      message = "FIELD_ARE_REQUIRED";
      break;

    case "WRONG_PASSWORD":
      error = true;
      status = 406;
      message = "WRONG_PASSWORD";
      break;

    case "USER_EXIST":
      error = true;
      status = 401;
      message = "USER_ALREADY_EXIST";
      break;

    case "PHONE_EXIST":
      error = true;
      status = 401;
      message = "PHONE_NUMBER_ALREADY_TAKED";
      break;

    case "ADMIN_EXIST":
      error = true;
      status = 401;
      message = "ADMIN_ALREADY_EXIST";
      break;

    case "REGISTRATION_FAILD":
      error = true;
      status = 401;
      message = "USER_REGISTRATION_FAILD";
      break;

    case "AUTH_FAILED":
      error = true;
      status = 417;
      message = "USER_NOT_FOUND";
      break;

    case "REGISTRED":
      error = false;
      status = 200;
      message = "SUCCESSFUL_REGISTRATION";
      break;

    case "LOGIN":
      error = false;
      status = 200;
      message = "SUCCESSFULLY_AUTHENTICATED";
      break;

    case "FAILED_DELETTION":
      error = true;
      status = 417;
      message = "DELETTION_REQUEST_FAILED";
      break;

    case "PROMOTION_ERROR":
      error = true;
      status = 401;
      message = "ERROR_IN_USER_PROMOTION";
      break;

    case "PROMOTED":
      error = false;
      status = 401;
      message = "USER_HAS_BEEN_PROMOTED";
      break;

    case "DELETED":
      error = false;
      status = 200;
      message = "SUCCESSFULLY_DELETED";
      break;

    case "REVOCATION_FAILED":
      error = true;
      status = 401;
      message = "REVOCATION_OPPERATION_FAILED";
      break;

    case "REVOKED":
      error = false;
      status = 401;
      message = "USER_HAS_BEEN_REVOKED";
      break;

    case "AUTHORIZED":
    case "SUCCESS":
      error = false;
      status = 200;
      message = "SUCCESS";
      break;

    case "REQUEST_LOAN":
      error = true;
      status = 401;
      message = "LOAN_NOT_AUTHORIZED_AT_THE_MOMENT";
      break;

    case "NOT_AUTHORIZED":
      error = true;
      status = 401;
      message = "NOT_AUTHORIZED_REQUEST";
      break;

    case "ACCESS_DENIED":
      error = true;
      status = 401;
      message = "ACCESS_DENIED";
      break;

    case "ERROR_LOAN":
      error = true;
      status = 401;
      message = "LOAN_ADDING_FAILD";
      break;

    case "LOAN_ADDED":
      error = false;
      status = 201;
      message = "LOAN_ADDED_SUCCESSFULLY";
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
