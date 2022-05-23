import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../../data/models/meal.dart';
import '../../mealpicker/controllers/mealpicker.controller.dart';

class MealListController extends GetxController {

  RxList meals = [].obs;
  final TextEditingController mealTextController = TextEditingController();

  String get newName => mealTextController.text;

  @override
  onInit() {
    try {
      Hive.registerAdapter(MealAdapter());
    } catch (e) {
      print(e);
    }
    getMeals();
    super.onInit();
  }

  addMeal() async {
    if (mealTextController.text.isEmpty) return;
    Meal addingMeal = Meal(name: mealTextController.text);
    mealTextController.text = '';

    meals.add(addingMeal);
    var box = await Hive.openBox('db');
    box.put('meals', meals.toList());
    print("Meal Object added $meals");
  }

  Future getMeals() async {
    Box box;
    print("Getting meals");
    try {
      box = Hive.box('db');
    } catch (error) {
      box = await Hive.openBox('db');
      print(error);
    }

    var mls = box.get('meals');
    print("MEALS $mls");
    if (mls != null) meals.value = mls;
  }

  deleteMeal(Meal meal) async {
    meals.remove(meal);
    var box = await Hive.openBox('db');
    box.put('meals', meals.toList());
  }

  editMealName(Meal meal, String newName) async {
    if (mealTextController.text.isEmpty) return;
    int index = meals.indexOf(meal);
    Meal editedMeal = meals[index];
    editedMeal.name = newName;
    meals[index] = editedMeal;
    var box = await Hive.openBox('db');
    box.put('meals', meals.toList());
  }
}
