import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/index.dart';
import '../../index.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Skip(),
      builder: (_) {
        if (_.isSkip.value) {
          return const FormScreen();
        } else {
          return OnbordingModel(
            items: help.onboardingListItem,
            onTap: () async => await _.toggleSkip(_),
          );
        }
      },
    );
  }
}

class Skip extends GetxController {
  RxBool _isSkip = false.obs;

  Skip() {
    getSkipPreference();
    update();
  }

  RxBool get isSkip => _isSkip;

  set isSkip(RxBool value) {
    _isSkip = value;

    help.writeDataToStorage('isSkip', value.value.toString());
    update();
  }

  Future<void> getSkipPreference() async {
    final value = await help.readDataFromStorage('isSkip');
    if (value == 'true') {
      _isSkip.value = true;
    } else {
      _isSkip.value = false;
    }
    update();
  }

  // Toggle between skip and unskip mode
  Future<void> toggleSkip(Skip value) async {
    value.isSkip.value = !value.isSkip.value;

    await help.writeDataToStorage('isSkip', value._isSkip.value.toString());

    update();
  }
}
