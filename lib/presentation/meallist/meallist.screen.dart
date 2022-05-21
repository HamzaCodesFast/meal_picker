import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_picker/data/models/meal.dart';

import '../../infrastructure/theme/theme_colors.dart';
import 'controllers/meallist.controller.dart';

class MealListScreen extends GetView<MealListController> {
  @override
  final controller = Get.put(MealListController());

  void addMeal() {
    // if text is empty
    if (controller.addMealTextController.text.isEmpty) return;

    Meal addingMeal = Meal(name: controller.addMealTextController.text);

    // empty TextField
    controller.addMealTextController.text = '';
    controller.addMeal(addingMeal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Meal List'),
        //Choose Meal
        centerTitle: true,
        backgroundColor: surface2Color,
        foregroundColor: onSurfaceColor,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showTextInputDialog(context);
          //showModalBottomSheet(context: context, builder: (context) => _modalBottomSheet());
        },
        label: Text('Add Meal'),
        icon: Icon(Icons.add),
        backgroundColor: primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _buildMealsList(),
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
                onLongPress: () {},
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

  Future<String?> _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Meal'),
            content: TextField(
              controller: controller.addMealTextController,
              decoration: InputDecoration(
                hintStyle: TextTheme().bodyLarge?.copyWith(color: outlineColor),
                hintText: 'Enter meal name',
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(primary: primaryColor),
                child: const Text("Cancel"),
                onPressed: () {
                  controller.addMealTextController.text = '';
                  Get.back();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(primary: primaryColor),
                child: const Text('Add'),
                onPressed: () {
                  addMeal();
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
