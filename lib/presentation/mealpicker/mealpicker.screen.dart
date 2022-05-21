import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:meal_picker/presentation/screens.dart';

import '../../infrastructure/theme/theme_colors.dart';
import 'controllers/mealpicker.controller.dart';

class MealpickerScreen extends GetView<MealpickerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar:  AppBar(
        title: Text('Meal Picker'),
        //Choose Meal
        centerTitle: true,
        backgroundColor: surface2Color,
        foregroundColor: onSurfaceColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.list,
              color: onSurfaceVariantColor,
            ),
            onPressed: () {
              Get.to(MealListScreen());
            },
          )
        ],
      ),
      body: Center(
        child: Text(
          'MealpickerScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
