import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/database.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Map<String,String> currentUser = {};
  Future _futureUser;

  String _phone='';
  String _fullName='';
  String _gender='';
  String _dob='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureUser = getUser();
    _getUserData();
  }

  getUser() async{
    final _userData = await DBProvider.db.getUser();
    return _userData;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
             child: _getUserImage(),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(100, 16, 0, 0),
              ),
              Text(
                'Full Name : ',
                  style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              Text(
                getFullName(),
                 style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(100, 16, 0, 0),
              ),
              Text(
                'Phone Number : ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              Text(
                _phone==null?"null":_phone,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(100, 16, 0, 0),
              ),
              Text(
                'Birth Date : ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              Text(
                _dob==null?"null":_dob,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(100, 16, 0, 0),
              ),
              Text(
                'Gender : ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              Text(
                _gender==null?"null":_gender,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getUserImage() {
    List<dynamic> users;
    _futureUser.then((value) => {
      users = value,
      users.forEach((element) {
        if(element["IMAGE"] != null) {
          return Image.file(File(element["IMAGE"]));
        }
        return null;
      }),
    }
    );
  }

  void _getUserData(){
    setState(() {
      List<dynamic> users;
      _futureUser.then((value) => {
        users = value,
        users.forEach((element) {
          _phone = element["PHONE_NO"];
          _gender = element["GENDER"];
          _fullName = element["FULL_NAME"];
          _dob = element["DOB"];
        }),
      });
    });
  }

  String getFullName(){
    setState(() {
      List<dynamic> users;
      _futureUser.then((value) => {
        users = value,
        users.forEach((element) {
          _fullName = element["FULL_NAME"];
        }),
      });
    });
    return _fullName;
  }
  getPhone(){
    setState(() {
      List<dynamic> users;
      _futureUser.then((value) => {
        users = value,
        users.forEach((element) {
          _phone = element["PHONE_NO"];
        }),
      });
    });
    return _phone;
  }
  getDOB(){
    setState(() {
      List<dynamic> users;
      _futureUser.then((value) => {
        users = value,
        users.forEach((element) {
          _dob = element["DOB"];
        }),
      });
    });
    return _dob;
  }
  getGender(){
    setState(() {
      List<dynamic> users;
      _futureUser.then((value) => {
        users = value,
        users.forEach((element) {
          _gender = element["GENDER"];
          }),
      });
    });
    return _gender;
  }
}
