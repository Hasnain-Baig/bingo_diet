import 'dart:convert';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/dialog_box/error_dialog.dart';
import '../config/database_helper.dart';
import '../models/user_model.dart';

class SetUserDataController extends GetxController {
  TextEditingController _ageController = TextEditingController();
  TextEditingController get ageController => _ageController;

  TextEditingController _heightController = TextEditingController();
  TextEditingController get heightController => _heightController;

  bool _isMale = true;
  bool get isMale => _isMale;

  String _gender = "male";
  String get gender => _gender;

  double _age = 0;
  double get age => _age;

  double _height = 0;
  double get height => _height;

  String _userId = "myId";
  String get userId => _userId;

  bool _editUser = true;
  bool get editUser => _editUser;

  List _users = [];
  List get users => _users;

  Map _myUser = {};
  Map get myUser => _myUser;

  bool _isUserInitialized = false;
  bool get isUserInitialized => _isUserInitialized;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DatabaseHelper _dbHelper = DatabaseHelper();

  void onInit() {
    super.onInit();
    initUser();
  }

  initUser() async {
    try {
      await getUsers();

      if (isUserExists(_userId)) {
        _gender = jsonDecode(_myUser["Gender"]);
        _age = jsonDecode(_myUser["Age"]);
        _height = jsonDecode(_myUser["Height"]);
        _editUser = false;
      }

      _isUserInitialized = true;
      update();
    } catch (e) {
      print("E User init========>${e}");
    }
  }

  setGender() {
    _isMale = !_isMale;
    if (!_isMale) {
      _gender = "Female";
    } else {
      _gender = "Male";
    }
    update();
  }

  isUserExists(userId) {
    for (var user in _users) {
      if (userId == user["User_Id"]) {
        _myUser = user;
        return true;
      }
    }
    return false;
  }

  getUsers() async {
    try {
      print("getUsers");

      await _dbHelper.initDb();

      _users = await _dbHelper.getUsers();
    } catch (e) {
      print("E getting users--------->${e}");
    }
  }

  addUserRecord() async {
    await _dbHelper.initDb();

    UserModel user = UserModel(
      id: _userId,
      gender: _gender,
      age: _age,
      height: _height,
    );

    await _dbHelper.insertUserRecord(user);
    update();
  }

  editUserData() {
    _editUser = true;
    _ageController.text = _age.toString();
    _heightController.text = _height.toString();
    if (_gender == "Male") {
      _isMale = true;
    } else {
      _isMale = false;
    }
    update();
  }

  setData(context) async {
    if (_ageController.text != "") {
      try {
        _age = double.parse(_ageController.text);
      } catch (e) {
        showModal(
            configuration: FadeScaleTransitionConfiguration(),
            context: context,
            builder: (context) {
              return MyErrorDialog("Age can only be numeric.");
            });
        return;
      }
    } else {
      showModal(
          configuration: FadeScaleTransitionConfiguration(),
          context: context,
          builder: (context) {
            return MyErrorDialog("Age field is empty!");
          });
      return;
    }

    if (_heightController.text != "") {
      try {
        _height = double.parse(_heightController.text);
      } catch (e) {
        showModal(
            configuration: FadeScaleTransitionConfiguration(),
            context: context,
            builder: (context) {
              return MyErrorDialog("Height can only be numeric.");
            });
        return;
      }
    } else {
      showModal(
          configuration: FadeScaleTransitionConfiguration(),
          context: context,
          builder: (context) {
            return MyErrorDialog("Height field is empty!");
          });
      return;
    }

    try {
      _isLoading = true;
      update();

      _age = double.parse(_ageController.text);
      _height = double.parse(_heightController.text);

      if (isUserExists(_userId)) {
        await _dbHelper.updateUser({
          "Gender": jsonEncode(_gender),
          "Age": jsonEncode(_age),
          "Height": jsonEncode(_height),
        }, _userId);
      } else {
        await addUserRecord();
      }

      _ageController.clear();
      _heightController.clear();

      _editUser = false;
      print(_editUser);

      _isLoading = false;
      update();
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
}
