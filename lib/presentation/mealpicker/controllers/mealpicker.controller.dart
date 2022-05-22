import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/meal.dart';
import '../../meallist/controllers/meallist.controller.dart';

class MealPickerController extends GetxController {

  final pickedMeal = Rxn<Meal>();
  MealListController mealListController = Get.put(MealListController());

  bool get doMealsExist {
    List<Meal> meals = mealListController.meals.value;
    return meals.isNotEmpty;
  }

  bool get anyMealPickedYet {
    return pickedMeal.value == null;
  }

  String get getPickedMealText {
    String pickedMealText;

    if (!doMealsExist) {
      pickedMealText = 'Add meals to the list first so I can choose one for you.';
    } else if (anyMealPickedYet) {
      pickedMealText = 'What\'s for dinner today?';
    } else {
      pickedMealText = pickedMeal.value!.name;
    }
    return pickedMealText;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void pickMeal() {
    List<Meal> meals = mealListController.meals.value;
    if (meals.isEmpty) return;
    Meal randomMeal = (meals..shuffle()).first;
    pickedMeal.value = randomMeal;
  }
}
