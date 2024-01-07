import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsomenenyo/helpers/index.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Animation<Color?>? valueColor;

    return Scaffold(
      body: GetBuilder(
        init: Themes(),
        builder: (_) {
          return FutureBuilder(
            future: help.getColors(_),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: 1,
                            valueColor: valueColor,
                            strokeWidth: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: help.text(
                              text: "Loading...",
                              color: Colors.grey,
                              size: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: help.text(
                          text: appVersion,
                          color: Colors.grey,
                          size: 11,
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snap.hasError) {
                // Handle error state if needed
                return const Center(
                  child: Text("Error loading data."),
                );
              } else {
                return const OnboardingScreen();
              }
            },
          );
        },
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tsomenenyo/helpers/index.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     Animation<Color?>? valueColor;
//     return Scaffold(
//       body: GetBuilder(
//           init: Themes(),
//           builder: (_) {
//             return FutureBuilder(
//               future: help.getColors(_),
//               builder: (context, snap) {
//                 // var color = snap.data;
//                 // if (color == null || color.isEmpty) {
//                 //   return const Center(child: CircularProgressIndicator());
//                 // }
//                 if (snap.connectionState == ConnectionState.waiting) {
//                   return Stack(
//                     children: [
//                       Align(
//                         alignment: Alignment.center,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             CircularProgressIndicator(
//                               value: 1,
//                               valueColor: valueColor,
//                               strokeWidth: 2,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 15.0),
//                               child: help.text(
//                                 text: "Loading...",
//                                 color: Colors.grey,
//                                 size: 13,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Padding(
//                           padding: const EdgeInsets.only(bottom: 20.0),
//                           child: help.text(
//                             text: appVersion,
//                             color: Colors.grey,
//                             size: 11,
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 }
//                 return const OnboardingScreen();
//               },
//             );
//           }),
//     );
//   }
// }
