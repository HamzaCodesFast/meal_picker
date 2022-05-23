import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_picker/data/models/meal.dart';

import '../../infrastructure/theme/theme_colors.dart';
import '../../infrastructure/theme/theme_typo.dart';
import 'controllers/meallist.controller.dart';

class MealListScreen extends GetView<MealListController> {
  @override
  final controller = Get.put(MealListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: surface2Color,
      appBar: AppBar(
        title: Text('Meal List'),
        //Choose Meal
        centerTitle: true,
        backgroundColor: surface2Color,
        foregroundColor: onSurfaceColor,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _addMealDialog(context, "Meal", "Enter Meal name", "Cancel", "Add Meal", controller.addMeal);
        },
        label: Text('Add Meal'),
        icon: Icon(Icons.add),
        backgroundColor: primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Obx(
        () => (controller.meals.value.isEmpty) ? _noMeals() : _buildMealsList(),
      ),
    );
  }

  Widget _noMeals() {
    return Center(
      child: Text("You currently have no saved meals.", style: bodyLargeTypo.copyWith(color: onBackgroundColor)),
    );
  }

  Widget _buildMealsList() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: controller.meals.length,
          itemBuilder: (context, index) {
            Meal meal = controller.meals[index];
            return Dismissible(
              key: Key(meal.id),
              onDismissed: (DismissDirection direction) {
                controller.deleteMeal(meal);
              },
              child: GestureDetector(
                onLongPress: () {
                  _editMealNameDialog(context, "Edit Name", meal, "Cancel", "Edit Name");
                },
                child: MealListTile(
                  name: meal.name,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<String?> _addMealDialog(
    BuildContext context,
    String titleText,
    String hintText,
    String dismissText,
    String confirmText,
    Function() confirmFunction,
  ) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Meal'),
            content: TextField(
              controller: controller.mealTextController,
              autofocus: true,
              decoration: InputDecoration(
                hintStyle: TextTheme().bodyLarge?.copyWith(color: outlineColor),
                hintText: 'Enter meal name',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(primary: primaryColor),
                child: const Text("Cancel"),
                onPressed: () {
                  controller.mealTextController.text = '';
                  Get.back();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(primary: primaryColor),
                child: const Text('Add'),
                onPressed: () {
                  confirmFunction();
                  Get.back();
                },
              ),
            ],
          );
        });
  }

  Future<String?> _editMealNameDialog(
    BuildContext context,
    String titleText,
    Meal meal,
    String dismissText,
    String confirmText,
  ) async {
    return showDialog(
        context: context,
        builder: (context) {
          controller.mealTextController.text = meal.name;
          return AlertDialog(
            title: Text(titleText),
            content: TextField(
              controller: controller.mealTextController,
              style: TextTheme().bodyLarge?.copyWith(color: outlineColor),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(primary: primaryColor),
                child: Text(dismissText),
                onPressed: () {
                  Get.back();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(primary: primaryColor),
                child: Text(confirmText),
                onPressed: () {
                  controller.editMealName(meal, controller.mealTextController.text);
                  Get.back();
                },
              ),
            ],
          );
        });
  }
}

class MealListTile extends StatelessWidget {
  const MealListTile({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: outlineColor, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
