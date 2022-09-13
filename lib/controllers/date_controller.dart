import 'package:get/get.dart';

class DateController extends GetxController {
  DateTime _nowDate = DateTime.now();
  DateTime get nowDate => _nowDate;

  DateTime _weekDate = DateTime.now();
  DateTime get weekDate => _weekDate;

  List _weekDatesList = [];
  List get weekDatesList => _weekDatesList;

  bool _displayWeekDates = false;
  bool get displayWeekDates => _displayWeekDates;

  void onInit() {
    super.onInit();
    _weekDate = setWeekDate(_nowDate);
    print("oninit animation done");
  }

  setWeekDate(DateTime dateTime) {
    return DateTime(
        dateTime.year, dateTime.month, dateTime.day - dateTime.weekday % 7);
  }

  setWeekDay(index) {
    switch (index) {
      case 0:
        return "Sun";
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
    }
  }

  setMonth(month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
    }
  }

  moveToPreviousWeek() {
    _weekDate = _weekDate.subtract(Duration(days: 7));
    calculateWeekDates();
    update();
  }

  moveToNextWeek() {
    _weekDate = _weekDate.add(Duration(days: 7));
    calculateWeekDates();
    update();
  }

  compareDates(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  previousDate(DateTime date) {
    return date.subtract(Duration(days: 1));
  }

  nextDate(DateTime date) {
    return date.add(Duration(days: 1));
  }

  compareStringDate(DateTime d1, DateTime d2) {
    var result = d1.compareTo(d2);
    if (result == 1) {
      return false;
    } else {
      return true;
    }
  }

  calculateWeekDates() {
    _weekDatesList = [];
    for (var i = 0; i < 7; i++) {
      _weekDatesList.add(_weekDate.add(Duration(days: i)));
    }
    update();
  }

  showWeekDates(context) {
    calculateWeekDates();
    print(_weekDatesList[0].day);
    _displayWeekDates = true;
    update();
  }

  hideWeekDates(context) {
    _displayWeekDates = false;
    update();
  }
}
