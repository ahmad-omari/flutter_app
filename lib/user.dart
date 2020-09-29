import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  String PHONE_NO;
  String PASSWORD;
  String FULL_NAME;
  String GENDER;
  String DOB;
  String IMAGE;

  User({
    this.PHONE_NO,
    this.PASSWORD,
    this.FULL_NAME,
    this.GENDER,
    this.DOB,
    this.IMAGE
  });

  factory User.fromJson(Map<String,dynamic> json) => User(
      PHONE_NO: json["PHONE_NO"],
      PASSWORD: json["PASSWORD"],
      FULL_NAME: json["FULL_NAME"],
      GENDER: json["GENDER"],
      DOB: json["DOB"],
      IMAGE: json["IMAGE"],
  );

  Map<String,dynamic> toJson() => {
    "PHONE_NO": PHONE_NO,
    "PASSWORD": PASSWORD,
    "FULL_NAME": FULL_NAME,
    "GENDER": GENDER,
    "DOB": DOB,
    "IMAGE": IMAGE,
  };
}