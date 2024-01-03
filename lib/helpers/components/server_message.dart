import 'dart:developer';

import 'package:confetti/confetti.dart';
import 'package:get/get.dart';

import '../index.dart';

ConfettiController conffetiController =
    ConfettiController(duration: const Duration(seconds: 10));
serverMessage(
  String key,
) {
  String message;
  String title;

  switch (key) {
    case "MISSING_PHONE_NUMBER":
      message =
          "Phone number is a required field for continuation. Please provide this information to proceed.";
      showAlertDialog(text: message);
      break;

    case "MISSING_FIRST_NAME":
      message =
          "First name is a required field for continuation. Please provide this information to proceed.";
      showAlertDialog(text: message);
      break;

    case "MISSING_LAST_NAME":
      message =
          "Last name is a required field for continuation. Please provide this information to proceed.";
      showAlertDialog(text: message);
      break;

    case "MISSING_PASSWORD":
      message =
          "Password is a required field for continuation. Please provide this information to proceed.";
      showAlertDialog(text: message);
      break;

    case "WRONG_PASSWORD":
      message =
          "Incorrect Password. Please enter the correct password to proceed.";
      showAlertDialog(text: message);
      break;

    case "USER_ALREADY_EXIST":
      message =
          "User Already Exists. Please choose a different data or log in with your existing credentials.";
      showAlertDialog(text: message);
      break;

    case "PHONE_NUMBER_ALREADY_TAKED":
      message =
          "User Already Exists. Please choose a different phone number or log in with your existing credentials.";
      showAlertDialog(text: message);
      break;

    case "ADMIN_ALREADY_EXIST":
      message =
          "Admin Already Exists. Please choose a different data or log in with your existing credentials.";
      showAlertDialog(text: message);
      break;

    case "USER_REGISTRATION_FAILD":
      title = "Registration Failed.";
      message =
          "Unable to complete user registration. Please try again or contact support for assistance.";
      showAlertDialog(text: title, subTitle: message);
      break;

    case "USER_NOT_FOUND":
      title = "User Not Found.";
      message = "Please check your credentials and try again.";
      showAlertDialog(text: title, subTitle: message);
      break;

    case "SUCCESSFUL_REGISTRATION":
      conffetiController.play();
      title = "Successful Registration";
      message = "An email confirmation has been sent to you for verification.";
      Future.delayed(const Duration(seconds: 8), () {
        conffetiController.stop();
      });
      showAlertDialog(
          assetName: "validate.json",
          repeat: false,
          size: 80,
          text: title,
          subTitle: message);
      break;

    case "SUCCESSFULLY_AUTHENTICATED":
      message = "Successfully Authenticated. Welcome back!";
      showAlertDialog(
        assetName: "validate.json",
        isOnlyValidator: true,
      );

      Future.delayed(
        const Duration(seconds: 5),
        () {
          Get.back();
          log("Login page");
        },
      );
      break;

    case "DELETTION_REQUEST_FAILED":
      message = "Deletion Request Failed. Please try again.";
      showAlertDialog(text: message);
      break;

    case "ERROR_IN_USER_PROMOTION":
      title = "Error in User Promotion.";
      message = "Please contact support for assistance.";
      showAlertDialog(text: title, subTitle: message);
      break;

    case "USER_HAS_BEEN_PROMOTED":
      message = "User has been promoted successfully.";
      showAlertDialog(
        assetName: "validate.json",
        repeat: false,
        size: 80,
        text: message,
      );
      break;

    case "SUCCESSFULLY_DELETED":
      message = "Successfully deleted.";
      showAlertDialog(
        assetName: "validate.json",
        repeat: false,
        size: 80,
        text: message,
      );
      break;

    case "REVOCATION_OPPERATION_FAILED":
      message = "Revocation Operation Failed. Please try again.";
      showAlertDialog(text: message);
      break;

    case "USER_HAS_BEEN_REVOKED":
      message = "User has been revoked successfully.";
      showAlertDialog(
        assetName: "validate.json",
        repeat: false,
        size: 80,
        text: message,
      );
      break;

    case "AUTHORIZED":
    case "SUCCESS":
      message = "Operation Successful.";
      showAlertDialog(
        assetName: "validate.json",
        repeat: false,
        size: 80,
        text: message,
      );
      break;

    case "NOT_AUTHORIZED_REQUEST":
      message = "Not Authorized Request. Access denied.";
      showAlertDialog(text: message);
      break;

    case "ACCESS_DENIED":
      message = "Access Denied. You do not have permission for this request.";
      showAlertDialog(text: message);
      break;

    case "ERROR_SERVER":
    case "INTERNAL_SERVER_ERROR":
    default:
      title = "Internal Server Error.";
      message = "Please try again later or contact support for assistance.";
      showAlertDialog(text: title, subTitle: message);
      break;
  }
}
