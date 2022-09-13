import 'dart:async';
import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:diet_app/controllers/animation_controller.dart';
import 'package:diet_app/controllers/date_controller.dart';
import 'package:diet_app/models/diet_record_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/dialog_box/error_dialog.dart';
import '../components/dialog_box/track_graph_dialog.dart';
import '../config/database_helper.dart';

class HomeController extends GetxController {
  DateController _dateController = Get.put(DateController());

  TextEditingController _weightController = TextEditingController();
  TextEditingController get weightController => _weightController;
  TextEditingController _bodyFatController = TextEditingController();
  TextEditingController get bodyFatController => _bodyFatController;

  int _squareMeal = 24;
  int get squareMeal => _squareMeal;
  int _prizeMeal = 4;
  int get prizeMeal => _prizeMeal;
  double _goalMealCalories = 600;
  double get goalMealCalories => _goalMealCalories;
  double _prizeMealCalories = 1500;
  double get prizeMealCalories => _prizeMealCalories;
  double _currentWeight = 156;
  double get currentWeight => _currentWeight;
  double _weeklyChange = 0;
  double get weeklyChange => _weeklyChange;

  int _prizeMealCount = 0;
  int get prizeMealCount => _prizeMealCount;
  int _squareMealCount = 0;
  int get sqaureMealCount => _squareMealCount;

  List _mealList = [];
  List get mealList => _mealList;
  List _snacksList = [];
  List get snacksList => _snacksList;
  List _prizeMealList = [];
  List get prizeMealList => _prizeMealList;
  double _satisfactionLevel = 1;
  double get satisfactionLevel => _satisfactionLevel;
  double _bodyFat = 0;
  double get bodyFat => _bodyFat;

  String _goalBased = "Calories per meal";
  String get goalBased => _goalBased;

  double _numOfPrizeMeals = 3;
  double get numOfPrizeMeals => _numOfPrizeMeals;

  List _databaseData = [];
  List get databaseData => _databaseData;

  var todayDate;
  bool _dateExits = false;
  bool get dateExits => _dateExits;

  Map _oneRecord = {};
  Map get oneRecord => _oneRecord;

  List<ChartData> _chartData = [];
  List<ChartData> get chartData => _chartData;

  String _graphYear = "";
  String get graphYear => _graphYear;

  double _lastWeekWeight = 0;
  double get lastWeekWeight => _lastWeekWeight;
  double _thisWeekWeight = 0;
  double get thisWeekWeight => _thisWeekWeight;

  String _spotlightColor = "yellow";
  String get spotlightColor => _spotlightColor;

  DatabaseHelper _dbHelper = DatabaseHelper();
  MyAnimationController _animationController = Get.put(MyAnimationController());

  var _myTimer;

  bool _isHomeInitialized = false;
  bool get isHomeInitialized => _isHomeInitialized;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _hungerLevel = "Mild Hunger";
  String get hungerLevel => _hungerLevel;

  double _amountPerMeal = 0;
  double get amountPerMeal => _amountPerMeal;

  TextEditingController _amountPerMealController = TextEditingController();
  TextEditingController get amountPerMealController => _amountPerMealController;

  String _tmpGoal = "Calories per meal";
  String get tmpGoal => _tmpGoal;

  bool _isCircleLoading = false;
  bool get isCircleLoading => _isCircleLoading;

  late int _circleLoadingIndex;
  int get circleLoadingIndex => _circleLoadingIndex;

  late int _circleLoadingRowIndex;
  int get circleLoadingRowIndex => _circleLoadingRowIndex;

  late String _circleLoadingValue;
  String get circleLoadingValue => _circleLoadingValue;

  void onInit() {
    super.onInit();
    print("oninit home");
    _myTimer = new Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime now = DateTime.now();
      todayDate = now.toString().split(' ')[0];
      if (now.hour == 0 && now.minute == 0 && now.second == 0) {
        print("-----------------------------------------");
        initValues();
      }
    });

    initValues();
  }

  void onClose() {
    super.onClose();
    _myTimer.cancel();
  }

  bool isDateExists(incDate) {
    for (var record in _databaseData) {
      if (incDate.toString().split(' ')[0] == record["Date"]) {
        _oneRecord = record;
        return true;
      }
    }
    return false;
  }

  addDatesInDatabase() async {
    DateTime dt = DateTime.now();
    if (_databaseData.length > 0) {
      while (!isDateExists(dt.toString().split(' ')[0])) {
        dt = _dateController.previousDate(dt);
      }
      if (_dateController.compareStringDate(dt, DateTime.now())) {
        do {
          dt = _dateController.nextDate(dt);
          _mealList = [];
          _snacksList = [];
          _prizeMealList = [];
          await addDietRecord(dt.toString().split(' ')[0]);
        } while (!_dateController.compareDates(dt, DateTime.now()));
      }
    } else {
      await addDietRecord(dt.toString().split(' ')[0]);
    }
  }

  initValues() async {
    try {
      // todayDate = jsonEncode(todayDate);
      await getDietRecords();

// getting and init old values
      initPreValues();

//addDates
      await addDatesInDatabase();

// values init
      if (_databaseData.length > 0) {
        _oneRecord = _databaseData[_databaseData.length - 1];
        _mealList = jsonDecode(_oneRecord["Meals_List"]);
        _snacksList = jsonDecode(_oneRecord["Snacks_List"]);
        _prizeMealList = jsonDecode(_oneRecord["Prize_Meals_List"]);
      }

//splotlight values init
      await calculateWeeklyChange();

//graph calue init
      graphValuesInit();

//init prize meal Count
      calculatePrizeAndSquareMealCount();

//change to ui
      await Future.delayed(Duration(seconds: 1), () {
        _isHomeInitialized = true;
      });

      update();
    } catch (e) {
      print("E init========>${e}");
    }
  }

  initPreValues() {
    if (_databaseData.length > 0) {
      _oneRecord = _databaseData[_databaseData.length - 1];
      _goalBased = jsonDecode(_oneRecord["Goal_Based"]);
      _goalMealCalories = jsonDecode(_oneRecord["Goal_Meal_Calories"]);
      _prizeMealCalories = jsonDecode(_oneRecord["Prize_Meal_Calories"]);
      _numOfPrizeMeals = jsonDecode(_oneRecord["Number_Of_Prize_Meals"]);
      _currentWeight = jsonDecode(_oneRecord["Current_Weight"]);
      _bodyFat = jsonDecode(_oneRecord["Body_Fat"]);
      _satisfactionLevel = jsonDecode(_oneRecord["Satisfaction_Level"]);
      _amountPerMeal = jsonDecode(_oneRecord["Amount_Per_Meal"]);
      _hungerLevel = jsonDecode(_oneRecord["Hunger_Level"]);
      _tmpGoal = _goalBased;
    }
  }

  graphValuesInit() {
    _chartData = [];

    if (_databaseData.length > 3) {
      for (var i = (_databaseData.length - 4); i < _databaseData.length; i++) {
        Map weightGraphMap = {
          "weight": jsonDecode(_databaseData[i]["Current_Weight"]),
          "date": _databaseData[i]["Date"]
        };
        _graphYear = _databaseData[i]["Date"].toString().split('-')[0];
        var month = _databaseData[i]["Date"].toString().split('-')[1];
        var day = _databaseData[i]["Date"].toString().split('-')[2];
        month = _dateController.setMonth(int.parse(month));

        _chartData.add(ChartData("${day} ${month}", weightGraphMap["weight"]));
      }
    } else if (_databaseData.length > 0) {
      for (var i = 0; i < _databaseData.length; i++) {
        Map weightGraphMap = {
          "weight": jsonDecode(_databaseData[i]["Current_Weight"]),
          "date": _databaseData[i]["Date"]
        };

        _graphYear = _databaseData[i]["Date"].toString().split('-')[0];
        var month = _databaseData[i]["Date"].toString().split('-')[1];
        var day = _databaseData[i]["Date"].toString().split('-')[2];
        month = _dateController.setMonth(int.parse(month));

        _chartData.add(ChartData("${day} ${month}", weightGraphMap["weight"]));
      }
    }
    update();
  }

  checkSpotlight() {
    if (_weeklyChange < 0) {
      _spotlightColor = "green";
    } else if (_weeklyChange > 0) {
      _spotlightColor = "red";
    } else {
      _spotlightColor = "yellow";
    }
    update();
  }

  calculatePrizeAndSquareMealCount() {
    _prizeMealCount = 0;
    _squareMealCount = 0;

    DateTime thisWeekDate =
        _dateController.setWeekDate(_dateController.nowDate);
    DateTime dt = DateTime.now();

    var takenMealsCount = 0;
    var takenSnacksCount = 0;

    while (isDateExists(dt.toString().split(' ')[0])) {
      List tmpPrizeMealList = jsonDecode(_oneRecord["Prize_Meals_List"]);
      List tmpSnacksList = jsonDecode(_oneRecord["Snacks_List"]);
      List tmpMealsList = jsonDecode(_oneRecord["Meals_List"]);

      _prizeMealCount += tmpPrizeMealList.length;

      for (var i = 0; i < tmpMealsList.length; i++) {
        if (tmpMealsList[i]["value"] == true) {
          takenMealsCount += 1;
        }
      }

      for (var i = 0; i < tmpSnacksList.length; i++) {
        if (tmpSnacksList[i]["value"] == true) {
          takenSnacksCount += 1;
        }
      }

      if (dt.toString().split(' ')[0] ==
          thisWeekDate.toString().split(' ')[0]) {
        break;
      }
      dt = dt.subtract(Duration(days: 1));
    }

    _squareMealCount = (takenMealsCount + takenSnacksCount);

    update();
  }

  calculateWeeklyChange() async {
    await getDietRecords();

    //this week weight
    DateTime thisWeekDate =
        _dateController.setWeekDate(_dateController.nowDate);
    DateTime dt = DateTime.now();
    double thisWeekWeight = 0;
    double thisWeekWeightCounts = 0;

    while (isDateExists(dt.toString().split(' ')[0])) {
      thisWeekWeight += jsonDecode(_oneRecord["Current_Weight"]);
      thisWeekWeightCounts += 1;

      if (dt.toString().split(' ')[0] ==
          thisWeekDate.toString().split(' ')[0]) {
        break;
      }
      dt = dt.subtract(Duration(days: 1));
    }

    //pre week weight
    dt = thisWeekDate.subtract(Duration(days: 1));
    thisWeekDate = thisWeekDate.subtract(Duration(days: 7));
    double preWeekWeight = 0;
    double preWeekWeightCounts = 0;

    while (isDateExists(dt.toString().split(' ')[0])) {
      preWeekWeight += jsonDecode(_oneRecord["Current_Weight"]);
      preWeekWeightCounts += 1;

      if (dt.toString().split(' ')[0] ==
          thisWeekDate.toString().split(' ')[0]) {
        break;
      }
      dt = dt.subtract(Duration(days: 1));
    }

    if (!_lastWeekWeight.isNaN) {
      _lastWeekWeight = (preWeekWeight / preWeekWeightCounts);
    }
    _thisWeekWeight = (thisWeekWeight / thisWeekWeightCounts);

    // // init weekly change
    if (_lastWeekWeight > 0) {
      _weeklyChange = _thisWeekWeight - _lastWeekWeight;
    } else {
      _weeklyChange = 0;
    }

//init spotlight values
    checkSpotlight();
    update();
  }

  addDietRecord(date) async {
    await _dbHelper.initDb();

    DietRecordModel data = DietRecordModel(
      date: date,
      mealsList: _mealList,
      snacksList: _snacksList,
      prizeList: _prizeMealList,
      goalBased: _goalBased,
      amountPerMeal: _amountPerMeal,
      hungerLevel: _hungerLevel,
      goalMealCalories: _goalMealCalories,
      prizeMealCalories: _prizeMealCalories,
      numOfPrizeMeals: _numOfPrizeMeals,
      currentWeight: _currentWeight,
      bodyFat: _bodyFat,
      satisfactionLevel: _satisfactionLevel,
    );

    _dbHelper.insertDietRecord(data);
    update();
  }

  getDietRecords() async {
    try {
      await _dbHelper.initDb();
      _databaseData = await _dbHelper.getAllDietRecords();
    } catch (e) {
      print("E Getting Diet Records--------->${e}");
    }
  }

  setSatisfactionLevel(newValue) {
    _satisfactionLevel = newValue.roundToDouble();
    update();
  }

  setGoalBased(v) {
    _tmpGoal = v.toString();
    print(_goalBased);
    update();
  }

  setNumOfPrizeMeals(String val) {
    _numOfPrizeMeals = double.parse(val);
    print(_numOfPrizeMeals);
    update();
  }

  setHungerLevel(val) {
    _hungerLevel = val.toString();
    update();
  }

  setGoal(context) async {
    _goalBased = _tmpGoal;

    if (_goalBased != "Intuition") {
      if (_amountPerMealController.text != "") {
        try {
          _amountPerMeal = double.parse(_amountPerMealController.text);
        } catch (e) {
          showModal(
              configuration: FadeScaleTransitionConfiguration(),
              context: context,
              builder: (context) {
                return MyErrorDialog(
                    "${goalBased.toString().split(' ')[0]} can only be numeric!");
              });
          return;
        }
      } else {
        showModal(
            configuration: FadeScaleTransitionConfiguration(),
            context: context,
            builder: (context) {
              return MyErrorDialog(
                  "${goalBased.toString().split(' ')[0]} field is empty!");
            });
        return;
      }
    }

    try {
      _isLoading = true;
      update();

      if (isDateExists(todayDate)) {
        await _dbHelper.updateDietRecord({
          "Number_Of_Prize_Meals": jsonEncode(_numOfPrizeMeals),
          "Goal_Based": jsonEncode(_goalBased),
          "Hunger_Level": jsonEncode(_hungerLevel),
          "Goal_Meal_Calories": jsonEncode(_goalMealCalories),
          "Prize_Meal_Calories": jsonEncode(_prizeMealCalories),
        }, todayDate);
      } else {
        addDietRecord(todayDate);
      }

      _amountPerMealController.clear();
      _isLoading = false;
      update();
      Get.back();
    } catch (e) {
      _isLoading = false;
      update();
      showModal(
          configuration: FadeScaleTransitionConfiguration(),
          context: context,
          builder: (context) {
            return MyErrorDialog("Invalid values!");
          });
    }
  }

  setRecord(context) async {
    if (_weightController.text != "") {
      try {
        _currentWeight = double.parse(_weightController.text);
      } catch (e) {
        showModal(
            configuration: FadeScaleTransitionConfiguration(),
            context: context,
            builder: (context) {
              return MyErrorDialog("Weight can only be numeric.");
            });
        return;
      }
    }

    if (_bodyFatController.text != "") {
      try {
        _bodyFat = double.parse(_bodyFatController.text);
      } catch (e) {
        showModal(
            configuration: FadeScaleTransitionConfiguration(),
            context: context,
            builder: (context) {
              return MyErrorDialog("Fat can only be numeric.");
            });
        return;
      }
    }

    try {
      if (_bodyFat >= 0 && _bodyFat <= 100) {
        _isLoading = true;
        update();

        if (isDateExists(todayDate)) {
          await _dbHelper.updateDietRecord({
            "Current_Weight": jsonEncode(_currentWeight),
            "Body_Fat": jsonEncode(_bodyFat),
            "Satisfaction_Level": jsonEncode(_satisfactionLevel),
          }, todayDate);
        } else {
          await addDietRecord(todayDate);
        }

        await calculateWeeklyChange();
        checkSpotlight();
        graphValuesInit();

        _weightController.clear();
        _bodyFatController.clear();
        _isLoading = false;
        update();

        Get.back();
      } else {
        await getDietRecords();
        initPreValues();
        update();

        showModal(
            configuration: FadeScaleTransitionConfiguration(),
            context: context,
            builder: (context) {
              return MyErrorDialog("Body Fat should be in\nbetween 0 and 100!");
            });
      }
    } catch (e) {
      print("Err====>$e");
      await getDietRecords();
      initPreValues();
      _isLoading = false;
      update();

      showModal(
          configuration: FadeScaleTransitionConfiguration(),
          context: context,
          builder: (context) {
            return MyErrorDialog("Invalid values!");
          });
    }
  }

  takeAsPrizeMeal(context, val, date, rowIndex, index) async {
    if (_prizeMealCount < numOfPrizeMeals) {
      if (isDateExists(date.toString().split(' ')[0])) {
        _isCircleLoading = true;
        _circleLoadingIndex = index;
        _circleLoadingRowIndex = rowIndex;
        _circleLoadingValue = val;

        update();

        _mealList = jsonDecode(_oneRecord["Meals_List"]);
        _prizeMealList = jsonDecode(_oneRecord["Prize_Meals_List"]);
        _snacksList = jsonDecode(_oneRecord["Snacks_List"]);

        ifLoop:
        if (_prizeMealList.length > 0) {
          for (var i = 0; i < _prizeMealList.length; i++) {
            print(_prizeMealList[i]);
            if (_prizeMealList[i] == index) {
              break ifLoop;
            }
          }
          _prizeMealList.add(index);
        } else {
          _prizeMealList.add(index);
        }
        _mealList.removeWhere((element) => element["index"] == index);

        await _dbHelper.updateDietRecord({
          "Meals_List": jsonEncode(_mealList),
          "Prize_Meals_List": jsonEncode(_prizeMealList),
        }, date.toString().split(' ')[0]);
      }

      await getDietRecords();
      calculatePrizeAndSquareMealCount();
      _isCircleLoading = false;

      update();
    } else {
      showModal(
          configuration: FadeScaleTransitionConfiguration(),
          context: context,
          builder: (context) {
            return MyErrorDialog("Prize Meals Consumed!");
          });
    }
  }

  takeAsGoalMeal(value, date, rowIndex, tmpTrue, tmpFalse) async {
    if (isDateExists(date.toString().split(' ')[0])) {
      _isCircleLoading = true;
      _circleLoadingIndex = tmpFalse["index"];
      _circleLoadingRowIndex = rowIndex;
      _circleLoadingValue = value;

      update();

      _mealList = jsonDecode(_oneRecord["Meals_List"]);
      _prizeMealList = jsonDecode(_oneRecord["Prize_Meals_List"]);
      _snacksList = jsonDecode(_oneRecord["Snacks_List"]);

      if (value == "Meals") {
        ifMealsLoop:
        if (_mealList.length > 0) {
          for (var i = 0; i < _mealList.length; i++) {
            if (_mealList[i]["index"] == tmpFalse["index"] &&
                _mealList[i]["value"] == tmpFalse["value"]) {
              _mealList[i] = tmpTrue;
              break ifMealsLoop;
            } else if (_mealList[i]["index"] == tmpTrue["index"] &&
                _mealList[i]["value"] == tmpTrue["value"]) {
              break ifMealsLoop;
            }
          }
          _mealList.add(tmpTrue);
        } else {
          _mealList.add(tmpTrue);
        }
        _prizeMealList.removeWhere((element) => element == tmpTrue["index"]);
      } else if (value == "Snacks") {
        ifSnacksLoop:
        if (_snacksList.length > 0) {
          for (var i = 0; i < _snacksList.length; i++) {
            if (_snacksList[i]["index"] == tmpFalse["index"] &&
                _snacksList[i]["value"] == tmpFalse["value"]) {
              _snacksList[i] = tmpTrue;
              break ifSnacksLoop;
            } else if (_snacksList[i]["index"] == tmpTrue["index"] &&
                _snacksList[i]["value"] == tmpTrue["value"]) {
              break ifSnacksLoop;
            }
          }
          _snacksList.add(tmpTrue);
        } else {
          _snacksList.add(tmpTrue);
        }
      }

      await _dbHelper.updateDietRecord({
        "Meals_List": jsonEncode(_mealList),
        "Snacks_List": jsonEncode(_snacksList),
        "Prize_Meals_List": jsonEncode(_prizeMealList),
      }, date.toString().split(' ')[0]);
    }

    await getDietRecords();
    calculatePrizeAndSquareMealCount();
    _isCircleLoading = false;

    update();
  }

  takeAsSkip(value, date, rowIndex, tmpTrue, tmpFalse) async {
    if (isDateExists(date.toString().split(' ')[0])) {
      _isCircleLoading = true;
      _circleLoadingIndex = tmpFalse["index"];
      _circleLoadingRowIndex = rowIndex;
      _circleLoadingValue = value;
      update();

      _mealList = jsonDecode(_oneRecord["Meals_List"]);
      _prizeMealList = jsonDecode(_oneRecord["Prize_Meals_List"]);
      _snacksList = jsonDecode(_oneRecord["Snacks_List"]);

      if (value == "Meals") {
        ifMealsLoop:
        if (_mealList.length > 0) {
          for (var i = 0; i < _mealList.length; i++) {
            if (_mealList[i]["index"] == tmpTrue["index"] &&
                _mealList[i]["value"] == tmpTrue["value"]) {
              _mealList[i] = tmpFalse;
              break ifMealsLoop;
            } else if (_mealList[i]["index"] == tmpFalse["index"] &&
                _mealList[i]["value"] == tmpFalse["value"]) {
              break ifMealsLoop;
            }
          }
          _mealList.add(tmpFalse);
        } else {
          _mealList.add(tmpFalse);
        }
        _prizeMealList.removeWhere((element) => element == tmpFalse["index"]);
      } else if (value == "Snacks") {
        ifSnacksLoop:
        if (_snacksList.length > 0) {
          for (var i = 0; i < _snacksList.length; i++) {
            if (_snacksList[i]["index"] == tmpTrue["index"] &&
                _snacksList[i]["value"] == tmpTrue["value"]) {
              _snacksList[i] = tmpFalse;
              break ifSnacksLoop;
            } else if (_snacksList[i]["index"] == tmpFalse["index"] &&
                _snacksList[i]["value"] == tmpFalse["value"]) {
              break ifSnacksLoop;
            }
          }
          _snacksList.add(tmpFalse);
        } else {
          _snacksList.add(tmpFalse);
        }
      }

      await _dbHelper.updateDietRecord({
        "Meals_List": jsonEncode(_mealList),
        "Snacks_List": jsonEncode(_snacksList),
        "Prize_Meals_List": jsonEncode(_prizeMealList),
      }, date.toString().split(' ')[0]);
    }

    await getDietRecords();
    calculatePrizeAndSquareMealCount();
    _isCircleLoading = false;

    update();
  }

  isMealSelected(value, date, rowIndex, tmpTrue, tmpFalse) {
    if (isDateExists(date.toString().split(' ')[0])) {
      _mealList = jsonDecode(_oneRecord["Meals_List"]);
      _prizeMealList = jsonDecode(_oneRecord["Prize_Meals_List"]);
      _snacksList = jsonDecode(_oneRecord["Snacks_List"]);

      if (value == "Meals") {
        ifMealsLoop:
        for (var i = 0; i < _mealList.length; i++) {
          print(_prizeMealList.contains(tmpTrue["index"]));
          if ((_mealList[i]["index"] == tmpTrue["index"] &&
                  _mealList[i]["value"] == tmpTrue["value"]) ||
              (_mealList[i]["index"] == tmpFalse["index"] &&
                  _mealList[i]["value"] == tmpFalse["value"])) {
            return true;
          }
        }

        if (_prizeMealList.contains(tmpTrue["index"]) ||
            _prizeMealList.contains(tmpFalse["index"])) {
          return true;
        }
        return false;
      } else if (value == "Snacks") {
        ifSnacksLoop:
        for (var i = 0; i < _snacksList.length; i++) {
          if ((_snacksList[i]["index"] == tmpTrue["index"] &&
                  _snacksList[i]["value"] == tmpTrue["value"]) ||
              _snacksList[i]["index"] == tmpFalse["index"] &&
                  _snacksList[i]["value"] == tmpFalse["value"]) {
            return true;
          }
        }
        return false;
      }
    }
    return false;
  }

  unSelectMeal(value, date, rowIndex, tmpTrue, tmpFalse) async {
    if (isDateExists(date.toString().split(' ')[0])) {
      _isCircleLoading = true;
      _circleLoadingIndex = tmpFalse["index"];
      _circleLoadingRowIndex = rowIndex;
      _circleLoadingValue = value;
      update();

      _mealList = jsonDecode(_oneRecord["Meals_List"]);
      _prizeMealList = jsonDecode(_oneRecord["Prize_Meals_List"]);
      _snacksList = jsonDecode(_oneRecord["Snacks_List"]);

      if (value == "Meals") {
        ifMealsLoop:
        for (var i = 0; i < _mealList.length; i++) {
          if ((_mealList[i]["index"] == tmpTrue["index"] &&
                  _mealList[i]["value"] == tmpTrue["value"]) ||
              (_mealList[i]["index"] == tmpFalse["index"] &&
                  _mealList[i]["value"] == tmpFalse["value"])) {
            _mealList.removeAt(i);
            break ifMealsLoop;
          }
        }

        _prizeMealList.removeWhere((element) =>
            element == tmpTrue["index"] || element == tmpFalse["index"]);
      } else if (value == "Snacks") {
        ifSnacksLoop:
        for (var i = 0; i < _snacksList.length; i++) {
          if ((_snacksList[i]["index"] == tmpTrue["index"] &&
                  _snacksList[i]["value"] == tmpTrue["value"]) ||
              _snacksList[i]["index"] == tmpFalse["index"] &&
                  _snacksList[i]["value"] == tmpFalse["value"]) {
            _snacksList.removeAt(i);
            break ifSnacksLoop;
          }
        }
      }

      await _dbHelper.updateDietRecord({
        "Meals_List": jsonEncode(_mealList),
        "Snacks_List": jsonEncode(_snacksList),
        "Prize_Meals_List": jsonEncode(_prizeMealList),
      }, date.toString().split(' ')[0]);
    }
    await getDietRecords();
    calculatePrizeAndSquareMealCount();

    _isCircleLoading = false;
    update();
  }

  checkObjInFoodsList(index, value) {
    List myList = [];
    _mealList = jsonDecode(_oneRecord["Meals_List"]);
    _snacksList = jsonDecode(_oneRecord["Snacks_List"]);

    if (value == "Meals") {
      myList = _mealList;
    } else if (value == "Snacks") {
      myList = snacksList;
    }
    for (var i = 0; i < myList.length; i++) {
      if (myList[i]["value"] == true && myList[i]["index"] == index) {
        return true;
      }
    }
    return false;
  }

  checkIndexInFoodsList(index, value) {
    List myList = [];
    _mealList = jsonDecode(_oneRecord["Meals_List"]);
    _snacksList = jsonDecode(_oneRecord["Snacks_List"]);

    if (value == "Meals") {
      myList = _mealList;
    } else if (value == "Snacks") {
      myList = _snacksList;
    }
    for (var i = 0; i < myList.length; i++) {
      if (myList[i]["index"] == index) {
        return true;
      }
    }
    return false;
  }

  checkIndexInPrizeList(index, value) {
    if (value == "Meals") {
      _prizeMealList = jsonDecode(_oneRecord["Prize_Meals_List"]);
      for (var i = 0; i < _prizeMealList.length; i++) {
        if (_prizeMealList[i] == index) {
          return true;
        }
      }
    }
    return false;
  }
}
