import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app/LoginPage.dart';
import 'package:flutter_app/user.dart';
import 'package:flutter_app/utils/database.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class SignupPage extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confPasswordController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  DateTime _birthDate;
  int _genderValue;
  final picker = ImagePicker();
  File _image;

  String _phone;
  String _password;
  String _fullName;
  String _gender;
  String _dob;
  String _img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Signup Page'
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.blueAccent
                    ]
                )
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                width: 300,
                height: 500,
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _globalKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget> [
                        // Full name
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Full name'),
                          keyboardType: TextInputType.text,
                          controller: _nameController,
                          validator: (value){
                            _fullName = value;
                            if(value.isEmpty || value.length!=10){
                              return 'Invalid phone number';
                            }
                            return null;
                          },
                          onSaved: (value) {

                          },
                        ),
                        // Phone number
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Phone Number'),
                          keyboardType: TextInputType.number,
                          controller: _phoneController,
                          validator: (value){
                            _phone = value;
                            if(value.isEmpty || value.length!=10){
                              return 'Invalid phone number';
                            }
                            return null;
                          },
                          onSaved: (value) {

                          },
                        ),
                        // Password
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value) {
                            _password = value;
                            if(value.isEmpty || value.length<6){
                              return 'Invalid password';
                            }
                            return null;
                          },
                          onSaved: (value) {

                          },
                        ),
                        // Password Confirmation
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                          controller: _confPasswordController,
                          validator: (value) {
                            if(value == _passwordController.text){
                              _password = value;
                            }
                            if(value.isEmpty || value != _passwordController.text){
                              return 'Invalid password';
                            }
                            return null;
                          },
                          onSaved: (value) {

                          },
                        ),
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.calendar_today,color: Colors.blueAccent,),
                              onPressed: () {
                                showDatePicker(context: context, initialDate: _birthDate==null ? DateTime.now() : _birthDate, firstDate: DateTime(1900), lastDate: DateTime.now()
                                ).then((date)  {
                                  setState((){
                                    _birthDate = date;
                                    _dob = _birthDate.day.toString()+'/'+_birthDate.month.toString()+'/'+_birthDate.year.toString();
                                  });
                                });
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,0,5.0,0),
                              child: Text(_birthDate==null ? 'Pick your birth date' : _birthDate.day.toString()+'/'+_birthDate.month.toString()+'/'+_birthDate.year.toString()),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                                'Choose your gender'
                            ),
                          ],
                        ),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      value: 1,
                                      groupValue: _genderValue,
                                      onChanged: (value) => _genderSelected(value),
                                    ),
                                    Text('Male'),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      value: 2,
                                      groupValue: _genderValue,
                                      onChanged: (value) => _genderSelected(value),
                                    ),
                                    Text('Female'),
                                  ],
                                ),
                              ],
                            ),
                        Row(
                          children: <Widget>[
                            RaisedButton(
                              child: Text('Choose image'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              color: Colors.blueAccent,
                              textColor: Colors.white,
                              onPressed: pickImage,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget> [
                            _image==null ? Text('No image selected') :
                            Container(
                              width: 250,
                              height: 250,
                              child: Image.file(_image),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton(
                          child: Text('Signup'),
                          onPressed: _SignupUser,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _genderSelected(int value){
    setState(() {
      _genderValue = value;
      if(value == 1){
        _gender = 'Male';
      }else if(value == 2){
        _gender = 'Female';
      }else{
        _gender = null;
      }
    });
  }

  Future pickImage()async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _img = pickedFile.path;
      } else {
        _img = null;
        print('No image selected.');
      }
    });
  }


  void _SignupUser(){
    _fullName = _nameController.text;
    _phone = _phoneController.text;
    if(_passwordController.text == _confPasswordController.text){
      _password = _passwordController.text;
    }

    var newUser = User(PHONE_NO: _phone,PASSWORD: _password,FULL_NAME: _fullName,GENDER: _gender,DOB: _dob,IMAGE: _img);
    if((_fullName !=null) && (_phone.length == 10) && (_password.length >= 6) && (_dob != null) && (_gender != null) && (_img != null)) {
      DBProvider.db.addUser(newUser);
      Navigator.pushNamed(context, LoginPage.routeName);
    }
  }
}
