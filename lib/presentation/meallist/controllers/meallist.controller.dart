import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../../data/models/meal.dart';

class MealListController extends GetxController {
  RxList meals = [].obs;

  final TextEditingController addMealTextController = TextEditingController();

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

  addMeal(Meal meal) async {
    meals.add(meal);
    var box = await Hive.openBox('db');
    box.put('meals', meals.toList());
    print("To Do Object added $meals");
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
    print("TODOS $mls");
    if (mls != null) meals.value = mls;
  }

  clearTodos() {
    try {
      Hive.deleteBoxFromDisk('db');
    } catch (error) {
      print(error);
    }
    meals.value = [];
  }

  deleteTodo(Meal meal) async {
    meals.remove(meal);
    var box = await Hive.openBox('db');
    box.put('meals', meals.toList());
  }
}
