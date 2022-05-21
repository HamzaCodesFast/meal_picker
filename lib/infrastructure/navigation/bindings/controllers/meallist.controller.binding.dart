import 'package:get/get.dart';

import '../../../../presentation/meallist/controllers/meallist.controller.dart';

class MeallistControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MealListController>(
      () => MealListController(),
    );
  }
}
