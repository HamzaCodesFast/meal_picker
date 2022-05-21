import 'package:get/get.dart';

import '../../../../presentation/mealpicker/controllers/mealpicker.controller.dart';

class MealpickerControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MealpickerController>(
      () => MealpickerController(),
    );
  }
}
