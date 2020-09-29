import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/LoginPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget> [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  colors: [Colors.blue,Colors.blueAccent],
                )
            ),
          ),
          Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Flutter App',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                      child: CircularProgressIndicator(
                        strokeWidth: 4.0,
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),

                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}

