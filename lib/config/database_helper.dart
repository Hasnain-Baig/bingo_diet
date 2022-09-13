import 'package:diet_app/models/diet_record_model.dart';
import 'package:diet_app/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  late Database db;
  final String dietTable = "Diet";
  final String columnDate = "Date";
  final String columnMealsList = "Meals_List";
  final String columnSnacksList = "Snacks_List";
  final String columnPrizeMealsList = "Prize_Meals_List";
  final String columnGoalBased = "Goal_Based";
  final String columnAmountPerMeal = "Amount_Per_Meal";
  final String columnHungerLevel = "Hunger_Level";
  final String columnGoalMealCalories = "Goal_Meal_Calories";
  final String columnPrizeMealCalories = "Prize_Meal_Calories";
  final String columnNumOfPrizeMeals = "Number_Of_Prize_Meals";
  final String columnCurrentWeight = "Current_Weight";
  final String columnBodyFat = "Body_Fat";
  final String columnSatisfactionLevel = "Satisfaction_Level";

  final String userTable = "User";
  final String columnUserId = "User_Id";
  final String columnGender = "Gender";
  final String columnAge = "Age";
  final String columnHeight = "Height";

  Future<void> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "diet_record.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
    final userIdType = 'TEXT PRIMARY KEY';
    final dietIdType = 'TEXT PRIMARY KEY';
    final textType = 'TEXT';

    await db.execute('''
CREATE TABLE $dietTable(
  ${columnDate} $dietIdType,
  ${columnMealsList} $textType,
  ${columnSnacksList} $textType,
  ${columnPrizeMealsList} $textType,
  ${columnGoalBased} $textType,
  ${columnAmountPerMeal} $textType,
  ${columnHungerLevel} $textType,
  ${columnGoalMealCalories} $textType,
  ${columnPrizeMealCalories} $textType,
  ${columnNumOfPrizeMeals} $textType ,
  ${columnCurrentWeight} $textType,
  ${columnBodyFat} $textType,
  ${columnSatisfactionLevel} $textType
  )
''');

    await db.execute('''
CREATE TABLE $userTable(
  ${columnUserId} $userIdType,
  ${columnGender} $textType,
  ${columnAge} $textType,
  ${columnHeight} $textType
  )
''');
  }

  Future<void> insertDietRecord(DietRecordModel dietRecord) async {
    try {
      db.insert(dietTable, dietRecord.toMap());
    } catch (e) {
      print("Insert error : $e");
    }
  }

  Future<void> insertUserRecord(UserModel user) async {
    try {
      db.insert(userTable, user.toMap());
    } catch (e) {
      print("Insert error : $e");
    }
  }

  Future<List> getAllDietRecords() async {
    final List<Map<String, dynamic>> records =
        await db.rawQuery("SELECT * FROM ${dietTable} ORDER BY ${columnDate}");
    return records;
  }

  Future<List> getUsers() async {
    final List<Map<String, dynamic>> users =
        await db.rawQuery("SELECT * FROM ${userTable}");
    return users;
  }

  Future<int> updateDietRecord(Map<String, Object> data, date) async {
    try {
      return await db
          .update(dietTable, data, where: '$columnDate = ?', whereArgs: [date]);
    } catch (e) {
      print("Update error : $e");
      return -1;
    }
  }

  Future<int> updateUser(Map<String, Object> userData, userId) async {
    try {
      return await db.update(userTable, userData,
          where: '$columnUserId = ?', whereArgs: [userId]);
    } catch (e) {
      print("Update error : $e");
      return -1;
    }
  }
}
