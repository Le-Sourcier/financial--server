import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../helpers/index.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Column(
            children: [
              Obx(() {
                var colorValue = theme.isDark.value ? 0.1 : .3;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.grey.withOpacity(colorValue),
                        child: help.icon(
                          icon: CupertinoIcons.back,
                          color: theme.isDark.value
                              ? Colors.white
                              : Colors.black38,
                          size: 16,
                        ),
                      ),
                    ),
                    //Filter button
                    CircleAvatar(
                      // radius: 19,
                      backgroundColor: Colors.grey.withOpacity(colorValue),
                      child: help.icon(
                        icon: Icons.filter_alt_outlined,
                        onTap: () {},
                        size: 20,
                        color: Colors.grey.withOpacity(0.9),
                      ),
                    ),
                  ],
                );
              }),
              Expanded(
                child: FutureBuilder(
                    future: null,
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      if (data != null) {
                        return _notifBody();
                      }
                      return _noNotif();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Show all the notification message here!
  Widget _notifBody() {
    return Column(
      children: [
        help.text(text: "Hello you!"),
      ],
    );
  }

  //Show no notification message whille there is any notification
  Widget _noNotif() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: "notif",
          child: Lottie.asset("assets/lotties/no_notifications.json"),
        )
      ],
    );
  }
}
