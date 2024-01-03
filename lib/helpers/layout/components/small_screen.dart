import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsomenenyo/controllers/index.dart';

import '../../../screens/index.dart';
import '../../../validators/user_validator.dart';
import '../../index.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen({Key? key}) : super(key: key);
  static double padding = 10.0;
  static var isAddData = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return IndexedStack(
            index: currentIndex.value,
            children: _screen,
          );
        },
      ),
      bottomSheet: _bottonNavBar(),
      floatingActionButton: _addButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  //List of screen
  static final List<Widget> _screen = [
    _dashBord(),
    const WalletScreen(),
    // const StaticsScreen(),
    const SettingsScreen(),
  ];

  //Dashboard screen
  static Widget _dashBord() {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: Obx(
        () {
          var bgColor = Colors.grey.withOpacity(0.2);
          return AnimatedPadding(
            duration: const Duration(milliseconds: 500),
            padding: EdgeInsets.only(
              left: isViewAll.value ? 0 : padding + 5,
              right: isViewAll.value ? 0 : padding + 5,
              top: padding,
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    radius: 23,
                  ),
                  title: help.text(
                    text: 'Hi 👋',
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: help.text(
                    text: 'DaviSon',
                    color: Colors.grey,
                  ),
                  trailing: Hero(
                    tag: "notif",
                    child: help.icon(
                      icon: CupertinoIcons.bell_fill,
                      radius: 17,
                      color: Colors.amber,
                      badgeStyle: BadgeStyle(
                        borderSide: BorderSide(
                          color: bgColor,
                          width: 1.5,
                        ),
                      ),
                      showBadge: true,
                      backgroundColor: Colors.grey.withOpacity(.2),
                      onTap: () => Get.toNamed("/notif"),
                    ),
                  ),
                ),

                //##### Body contents ####
                //Speculation card
                Flexible(
                  flex: 1,
                  child: PageView(
                    controller: PageController(viewportFraction: 0.92),
                    children: List.generate(2, (index) => _card()),
                  ),
                ),
                //Last activities card
                Expanded(
                  flex: 2,
                  child: _activityCards(
                    elevation: isViewAll.value ? 0 : null,
                    bgColor: isViewAll.value ? Colors.transparent : null,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  //Speculation cards
  static Widget _card() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 10),
      child: Card(
        // color: Colors.red,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          // height: Get.width * 0.5,

          decoration: BoxDecoration(
            // color: Colors.red,
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: help.cardColor,
            ),
          ),
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        help.text(
                          text: translator.translate("BALANCE").value,
                          fontWeight: FontWeight.bold,
                          size: 16,
                          color: Colors.white,
                        ),
                        help.text(
                          text: "Tsomenonyo",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ],
                    );
                  },
                ),
                //Total Amount
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: help.text(
                    text: "200.000 XOF",
                    size: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      help.text(
                        text: "1234 5678 9012 1275",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      help.text(
                        text: "02/25",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Activities Cards
  static Widget _activityCards({
    Color? bgColor,
    double? elevation,
  }) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 500),
      padding: EdgeInsets.only(
          bottom: isViewAll.value ? 0 : Get.height - (Get.height * 0.903),
          top: 10),
      child: Card(
        color: bgColor,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Obx(
          () {
            isViewAll.value;
            return SizedBox(
              width: Get.width,
              child: Column(
                children: [
                  isViewAll.value
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: help.icon(
                                    icon: Icons.info_outline,
                                    color: Colors.grey.withOpacity(.5)),
                                onTap: () {
                                  help.customDialog(
                                    body: help.text(
                                        text: translator
                                            .translate("FINANCIAL_INFO")
                                            .value),
                                  );
                                },
                              ),
                              GestureDetector(
                                onTap: () => isViewAll.value = !isViewAll.value,
                                child: help.icon(
                                    icon: CupertinoIcons
                                        .arrow_down_right_arrow_up_left),
                              ),
                            ],
                          ),
                        )
                      : ListTile(
                          leading: help.text(
                            text: translator.translate("LAST_ACTIVITIES").value,
                            size: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          trailing: _testData.length <= 5
                              ? const SizedBox()
                              : GestureDetector(
                                  child: help.text(
                                    text: translator.translate("SEE_ALL").value,
                                    color:
                                        const Color.fromARGB(255, 2, 79, 143),
                                  ),
                                  onTap: () =>
                                      isViewAll.value = !isViewAll.value,
                                ),
                        ),
                  //Divider line
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(color: Colors.grey.withOpacity(0.3)),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: ListView(
                        children: List.generate(
                          isViewAll.value
                              ? _testData.length
                              : _lenghtChecker(_testData.length),
                          (index) {
                            var data = _testData[index];
                            return ListTile(
                              leading: Card(
                                elevation: 0.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: help.icon(
                                    icon: !isTrue(data['type'])
                                        ? CupertinoIcons.arrow_down_left
                                        : CupertinoIcons.arrow_up_right,
                                    color: !isTrue(data['type'])
                                        ? Colors.pink
                                        : Colors.green,
                                  ),
                                ),
                              ),
                              title: help.text(
                                  text: _activitiesHeader(data['type'])),
                              subtitle: help.text(
                                  text: data["date"],
                                  size: 13,
                                  color: Colors.grey),
                              trailing: help.text(
                                text: "${isTrue(data['type']) ? "+" : "-"}"
                                    "${data['amount']} XOF",
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

//Bottom navigation bard
  Widget _bottonNavBar() {
    return Obx(
      () {
        isViewAll.value;
        return AnimatedPadding(
          duration: const Duration(milliseconds: 500),
          padding: EdgeInsets.only(
              bottom: isViewAll.value ? 0 : 4.0,
              left: isViewAll.value || isAddData.value ? 0 : (padding + 6),
              right: isViewAll.value || isAddData.value ? 0 : (padding + 6)),
          child: Card(
            margin: isViewAll.value ? EdgeInsets.zero : null,
            color: isViewAll.value || isAddData.value
                ? Colors.transparent
                : help.appColorDark,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Obx(
              () {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: isViewAll.value
                      ? (Get.height * 0.90)
                      : isAddData.value
                          ? (Get.height * 0.96)
                          : 55.0,
                  width: isViewAll.value
                      ? (Get.width - 25)
                      : isAddData.value
                          ? (Get.width - 35)
                          : Get.width,
                  child: isViewAll.value
                      ? _activityCards()
                      : isAddData.value
                          ? _addDataModal()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(
                                _menuIcons(currentIndex.value).length,
                                (index) {
                                  var data =
                                      _menuIcons(currentIndex.value)[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25.0),
                                    child: Obx(
                                      () {
                                        return GestureDetector(
                                          child: help.icon(
                                            icon: data,
                                            color: currentIndex.value == index
                                                ? Colors.white
                                                : Colors.grey,
                                          ),
                                          onTap: () {
                                            currentIndex.value = index;
                                          },
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                );
              },
            ),
          ),
        );
      },
    );
  }

//Add button
  Widget _addButton() {
    return Obx(
      () {
        isViewAll.value;
        if (isViewAll.value || isAddData.value || currentIndex.value != 0) {
          return const SizedBox();
        }
        return GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 23.0),
            child: CircleAvatar(
              radius: 30.0,
              backgroundColor: Get.theme.canvasColor,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: CircleAvatar(
                  backgroundColor: help.appColorDark,
                  radius: 30.0,
                  child:
                      help.icon(icon: Icons.add, size: 30, color: Colors.white),
                ),
              ),
            ),
          ),
          onTap: () {
            isAddData.value = !isAddData.value;
            // Get.bottomSheet(
            //   CupertinoActionSheet(
            //     message: SizedBox(
            //         height: Get.height / 1.5,
            //         child: Column(
            //           children: [
            //             help.text(text: "Hello"),
            //           ],
            //         )),
            //   ),
            // );
          },
        );
      },
    );
  }

//Add data modal
  Widget _addDataModal() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: Get.height,
      // color: Colors.transparent,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    help.icon(
                      icon: Icons.horizontal_rule_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                    GestureDetector(
                      onTap: () => isAddData.value = !isAddData.value,
                      child: CircleAvatar(
                        radius: 15,
                        child: help.icon(
                          icon: Icons.close,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: SizedBox(
                  height: 50,
                  // padding: const EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.center,
                    child: CustomForm(
                      controller: searchController,
                      textInputType: TextInputType.text,
                      label: "Search ...",
                      icon: CupertinoIcons.search,
                      elevation: 0,
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 120,
              //   width: Get.width,
              //   child: LineChart(
              //     LineChartData(
              //       backgroundColor: Colors.red,
              //       // maxX: 10,
              //       // minX: 8,
              //       // maxY: 6,
              //       // minY: 8,
              //       // lineBarsData: [
              //       //   LineChartBarData(
              //       //     spots: [],
              //       //     isCurved: true,
              //       //   ),
              //       // ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  //Menu icons
  static List<dynamic> _menuIcons(int index) => [
        index == 0
            ? CupertinoIcons.rectangle_grid_2x2_fill
            : CupertinoIcons.rectangle_grid_2x2,
        index == 1
            ? Icons.account_balance_wallet
            : Icons.account_balance_wallet_outlined,
        // CupertinoIcons.chart_bar_square_fill,
        index == 2 ? CupertinoIcons.gear_alt_fill : CupertinoIcons.gear_alt,
      ];

  static String _activitiesHeader(String type) {
    switch (type) {
      case "DEBITED":
        return translator.translate("DEBITED").value;
      case "BORROWED":
        return translator.translate("BORROWED").value;
      case "REPAID":
        return translator.translate("REPAID").value;
      default:
        return translator.translate("INCOMING_AM").value;
    }
  } // Widget build(BuildContext context) {

  static bool isTrue(String type) {
    switch (type) {
      case "CREDITED":
      case "REPAID":
        return true;
      case "DEBITED":
      case "BORROWED":
        return false;
      default:
        return false;
    }
  }

  //Activities data lenght checker
  static int _lenghtChecker(int index) {
    if (index <= 5) {
      return index;
    } else {
      return index = 5;
    }
  }

  static final List _testData = [
    {"type": "CREDITED", "amount": "2000", "date": "Jan 10, 7Am : 10"},
    {"type": "CREDITED", "amount": "1000", "date": "Jan 18, 7Am : 00"},
    {"type": "CREDITED", "amount": "7000", "date": "Jan 25, 6Am : 00"},
    {"type": "CREDITED", "amount": "20000", "date": "Mar 21, 6Am : 36"},
    {"type": "DEBITED", "amount": "40000", "date": "May 18, 7Am : 02"},
    {"type": "DEBITED", "amount": "160000", "date": "Jun 01, 7Am : 12"},
    {"type": "DEBITED", "amount": "60000", "date": "Jul 18, 6Am : 02"},
    {"type": "BORROWED", "amount": "10000", "date": "Oct 02, 6Am : 18"},
    {"type": "REPAID", "amount": "16500", "date": "Dec 08, 6Am : 22"},
    {"type": "REPAID", "amount": "16500", "date": "Dec 08, 6Am : 22"},
    {"type": "REPAID", "amount": "16500", "date": "Dec 08, 6Am : 22"}
  ];
}
