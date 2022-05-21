import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:meal_picker/data/models/meal.dart';

class MealsDatabase extends GetxController {
  Box<Meal> getMeals() => Hive.box<Meal>('meals');

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    Hive.box('meals').close();
    super.onClose();
  }

}
