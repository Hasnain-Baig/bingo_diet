import 'dart:convert';

class UserModel {
  final String id;
  final String gender;
  final double age;
  final double height;

  UserModel(
      {required this.id,
      required this.gender,
      required this.age,
      required this.height});

  Map<String, dynamic> toMap() {
    return {
      "User_Id": this.id,
      "Gender": jsonEncode(this.gender),
      "Age": jsonEncode(this.age),
      "Height": jsonEncode(this.height),
    };
  }
}
