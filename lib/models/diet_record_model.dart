import 'dart:convert';

import 'package:diet_app/controllers/date_controller.dart';
import 'package:get/get.dart';

class DietRecordModel {
  String date;
  List mealsList;
  List snacksList;
  List prizeList;
  String goalBased;
  double amountPerMeal;
  String hungerLevel;
  double goalMealCalories;
  double prizeMealCalories;
  double numOfPrizeMeals;
  double currentWeight;
  double bodyFat;
  double satisfactionLevel;

  DietRecordModel({
    required this.date,
    required this.mealsList,
    required this.snacksList,
    required this.prizeList,
    required this.goalBased,
    required this.amountPerMeal,
    required this.hungerLevel,
    required this.goalMealCalories,
    required this.prizeMealCalories,
    required this.numOfPrizeMeals,
    required this.currentWeight,
    required this.bodyFat,
    required this.satisfactionLevel,
  });

  DateController _dateController = Get.put(DateController());

  Map<String, dynamic> toMap() {
    return {
      "Date": this.date,
      "Meals_List": jsonEncode(this.mealsList),
      "Snacks_List": jsonEncode(this.snacksList),
      "Prize_Meals_List": jsonEncode(this.prizeList),
      "Goal_Based": jsonEncode(this.goalBased),
      "Amount_Per_Meal": jsonEncode(this.amountPerMeal),
      "Hunger_Level": jsonEncode(this.hungerLevel),
      "Goal_Meal_Calories": jsonEncode(this.goalMealCalories),
      "Prize_Meal_Calories": jsonEncode(this.prizeMealCalories),
      "Number_Of_Prize_Meals": jsonEncode(this.numOfPrizeMeals),
      "Current_Weight": jsonEncode(this.currentWeight),
      "Body_Fat": jsonEncode(this.bodyFat),
      "Satisfaction_Level": jsonEncode(this.satisfactionLevel),
    };
  }
}
