import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/UserProfilPage.dart';
import './UserHomePage.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: _fragmentSelectedWidget(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: colorScheme.surface,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        onTap: (value) {
          // Respond to item press.
          setState(() => _selectedNavigatorTab(value));
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Home Page'),
            icon: Icon(Icons.home,),

          ),
          BottomNavigationBarItem(
            title: Text('Profile Page'),
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }

  Widget _fragmentSelectedWidget(){
    switch(_currentIndex){
      case 0:
        return UserHomePage();
        break;
      case 1:
        return UserProfilePage();
        break;
    }
  }

  void _selectedNavigatorTab(value){
    setState(() {
      _currentIndex = value;
    });
  }
}

