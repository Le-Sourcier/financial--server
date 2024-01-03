import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/index.dart';

// Service service = Get.put(Service());
late Service service;

class Service extends GetxController {
  // late User user;

  final String url = "http://192.168.122.1:8300";

  //Get user by id and token
  Future<User?> getUser() async {
    User userModel;
    try {
      // var id = await help.readDataFromStorage("id");
      // var token = await help.readDataFromStorage("token");
      String id = "341060617516390";
      String token =
          "30VgGVr3lsH2Uf7JOeBg9216ST6LFK8ifK4B0Xxp7g1JB6N9Yp5o2H0DIOmAElMlnsJcittKu716kOJ5LPz7HPnIJuIA45GlO56PY92647jeB0tTYh4wVcmyAqsrDi5C7KBG1v2I51KnT2Vc2r5Wpb";

      final body = {
        "id": id,
      };
      final headers = {"Content-Type": "Application/json"};

      final response = await http.post(Uri.parse("$url/user/$token"),
          body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)["data"];
        var userData = await userProfile.get(id);
        userModel = User.getDatafromDatabase(userData);

        //###################### START SAVING ######################

        var profileModel = User.fromJson(data);
        var userData0 = User.fromJonToDatabase(profileModel);

        await userProfile.put(data['id'].toString(), userData0);

        //###################### END OF SAVING ######################

        if (userData == null || userModel.id.isEmpty) {
          // log(jsonResponse.toString());

          // userModel = User(
          //   id: jsonResponse["id"].toString(),
          //   firstname: jsonResponse["firstname"].toString(),
          //   lastname: jsonResponse["lastname"].toString(),
          //   phone: jsonResponse["phone"].toString(),
          //   image: jsonResponse["image"].toString(),
          //   online: jsonResponse["online"] == 1,
          // );
        }
        // log(serverResponse.toString());

        return userModel;
      }
    } catch (error) {
      log(error.toString());
    }
    return null;
  }

  @override
  void onInit() {
    // user;
    super.onInit();
  }
}
