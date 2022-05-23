import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../data/models/meal.dart';
import '../../meallist/controllers/meallist.controller.dart';

class MealPickerController extends GetxController {
  Rxn<Meal> confirmedMeal = Rxn<Meal>();
  Rxn<Meal> pickedMeal = Rxn<Meal>();
  RxList pickedMeals = [].obs;
  MealListController mealListController = Get.put(MealListController());

  // GETTER

  bool get doMealsExist {
    var meals = mealListController.meals.value;
    return meals.isNotEmpty;
  }

  bool get anyMealConfirmedYet {
    return confirmedMeal.value != null;
  }

  bool get anyMealPickedYet {
    return pickedMeal.value != null;
  }

  String get getPickedMealText {
    String pickedMealText;

    if (!doMealsExist) {
      pickedMealText = 'Add meals to the list first so I can choose one for you.';
    } else if (anyMealConfirmedYet) {
      pickedMealText = confirmedMeal.value!.name;
    } else if (anyMealPickedYet) {
      pickedMealText = pickedMeal.value!.name;
    } else {
      pickedMealText = 'What\'s for dinner today?';
    }
    return pickedMealText;
  }

  // METHODS

  void resetParameters() {
    confirmedMeal = Rxn<Meal>();
    pickedMeal = Rxn<Meal>();
    pickedMeals = [].obs;
  }

  void pickMeal() {
    confirmedMeal = Rxn<Meal>();

    var meals = mealListController.meals.value;
    if (meals.isEmpty) return;

    if (pickedMeals.isEmpty) {
      pickedMeals.value = List<Meal>.from(meals.toList());
      pickedMeals.sort((a, b) => a.frequency.compareTo(b.frequency));
    }

    pickedMeal.value = pickedMeals.first;
    pickedMeals.removeAt(0);
  }

  void confirmMeal() async {
    Meal meal = pickedMeal.value!;
    RxList meals = mealListController.meals;

    int index = mealListController.meals.indexOf(meal);
    Meal editedMeal = meals[index];
    editedMeal.frequency += 1;
    meals[index] = editedMeal;
    var box = await Hive.openBox('db');
    box.put('meals', meals.toList());

    print("confirmed Meal: ${pickedMeal.value!.name} | ${pickedMeal.value!.frequency}");
    pickedMeal = Rxn<Meal>();
  }

  void declineMeal() async {
    Meal meal = pickedMeal.value!;
    RxList meals = mealListController.meals;

    int index = mealListController.meals.indexOf(meal);
    Meal editedMeal = meals[index];
    editedMeal.frequency += 0.5;
    meals[index] = editedMeal;
    var box = await Hive.openBox('db');
    box.put('meals', meals.toList());

    print("confirmed Meal: ${pickedMeal.value!.name} | ${pickedMeal.value!.frequency}");
    pickedMeal = Rxn<Meal>();
  }

  // OVERRIDES

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
}
