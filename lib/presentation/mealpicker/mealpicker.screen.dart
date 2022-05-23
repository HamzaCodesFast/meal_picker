import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:meal_picker/infrastructure/theme/theme_typo.dart';
import 'package:meal_picker/presentation/screens.dart';
import 'package:meal_picker/presentation/widgets/primary_button.dart';

import '../../infrastructure/theme/theme_colors.dart';
import 'controllers/mealpicker.controller.dart';

class MealpickerScreen extends GetView<MealPickerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Meal Picker'),
        //Choose Meal
        centerTitle: true,
        backgroundColor: surface2Color,
        foregroundColor: onSurfaceColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.playlist_add_outlined,
              color: onSurfaceVariantColor,
            ),
            onPressed: () {
              Get.to(() => MealListScreen());
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Obx(
                      () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.anyMealConfirmedYet ? Text("Today we're having") : controller.anyMealPickedYet ? Text("Do you want") : Container(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        controller.getPickedMealText,
                        textAlign: TextAlign.center,
                        style: controller.anyMealConfirmedYet ? headlineSmallTypo.copyWith(color: successColor, fontWeight: FontWeight.w600) : (!(controller.anyMealPickedYet) ? bodyLargeTypo : headlineSmallTypo).copyWith(color: onBackgroundColor),
                      ),
                    ),
                    controller.anyMealConfirmedYet ? Text("Yay!") : controller.anyMealPickedYet ? Text("today?") : Container(),
                  ],
                ),),
              ),
            ),
            Obx(
              () => (controller.anyMealPickedYet)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrimaryButton(
                          label: "No",
                          icon: Icons.no_meals_outlined,
                          enabled: true,
                          onPressed: controller.declineMeal,
                        ),
                        SizedBox(width: 16),
                        PrimaryButton(
                          label: "Yes",
                          icon: Icons.restaurant_outlined,
                          enabled: true,
                          onPressed: controller.confirmMeal,
                        ),
                      ],
                    )
                  : PrimaryButton(
                      label: "Pick a meal",
                      icon: Icons.restaurant_menu_outlined,
                      enabled: controller.doMealsExist,
                      onPressed: controller.pickMeal,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
