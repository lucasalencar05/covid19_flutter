import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:covid19_flutter/views/personinfo.dart';
import 'countrylist.dart';
import 'globalinfo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<Widget> _widgets = <Widget> [
    GlobalInfoPage(),
    CountryListPage(),
    PersonalInfoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: <Widget>[
          Icon(Icons.public,
            size: 30,
            color: Theme.of(context).accentColor,
          ),
          Icon(Icons.view_headline,
            size: 30,
            color: Theme.of(context).accentColor,
          ),
          Icon(Icons.info,
            size: 30,
            color: Theme.of(context).accentColor,
          ),
        ],
        backgroundColor: Theme.of(context).accentColor,
        buttonBackgroundColor: Theme.of(context).primaryColor,
        color: Theme.of(context).primaryColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
      ),
      body: _widgets.elementAt(_currentIndex),
    );
  }
}