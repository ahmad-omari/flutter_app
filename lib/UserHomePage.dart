import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Home Page',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 24),),
          Padding(
            padding: EdgeInsets.all(16),
            child:           FutureBuilder(
              future: getData(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  final Map<String,Object> data = snapshot.data;
                  List<dynamic> info;

                  print(data["status"]);
                  //  print(value["data"]),
                  info =  data["data"];
                  StringBuffer sb = new StringBuffer();
                  info.forEach((element) {
                    sb.writeln(element["id"]+" "+element["employee_name"]+" "+element["employee_salary"]+" "+element["employee_age"]);
                    print(element["id"]);
                  });
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("ID Name Salary Age",
                              style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(sb.toString()),
                          ],
                        ),
                      ],
                    ),
                  );

                  //
                }
                return Container();
              },
            ),
          ),

        ],
      ),
    );
  }
  
  Future<Map<String,Object>> getData()async{
    final response = await http.get("http://dummy.restapiexample.com/api/v1/employees");
    return jsonDecode(response.body);
  }
}
