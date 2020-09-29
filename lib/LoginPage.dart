import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/HomePage.dart';
import 'package:flutter_app/SignupPage.dart';
import 'package:flutter_app/utils/database.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  Map<String,String> currentUser = {};
  Future _futureUser;
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureUser = getUser();
  }

  getUser() async{
      final _userData = await DBProvider.db.getUser();
      return _userData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login Page'
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
                width: 250,
                height: 300,
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _globalKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget> [
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Phone Number'),
                          keyboardType: TextInputType.number,
                          controller: _phoneController,
                          validator: (value){
                            if(value.isEmpty || value.length!=10){
                              return 'Invalid phone number';
                            }
                            return null;
                          },
                          onSaved: (value) {

                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value) {
                            if(value.isEmpty || value.length<6){
                              return 'Invalid password';
                            }
                            return null;
                          },
                          onSaved: (value) {

                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton(
                          child: Text('Login'),
                          onPressed: _LoginUser,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                          ),
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                        ),
                        FlatButton(
                          child: Text(
                            'Register now',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blueAccent
                            ),
                          ),
                          onPressed: () => Navigator.pushNamed(context, SignupPage.routeName),
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

  void _LoginUser(){
    List<dynamic> users;
    bool isValidUser = false;
    String phoneInput = _phoneController.text;
    String passwordInput = _passwordController.text;
    _futureUser.then((value) => {
      users = value,
      users.forEach((element) {
        if(phoneInput==element["PHONE_NO"] && passwordInput==element["PASSWORD"]){
          isValidUser = true;
        }
      }),
      if(isValidUser){
        Navigator.pushNamed(context, HomePage.routeName),
      }else{

      }
    });

  }
}
