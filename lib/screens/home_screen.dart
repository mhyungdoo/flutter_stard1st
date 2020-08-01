import 'package:flutter/material.dart';
import 'package:stard1stprojectrev0/screens/db_screen.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: RaisedButton(
                  child: Text('DB Screen'),
                  onPressed: () {
                    Navigator.pushNamed(context, DbScreen.id);
                  },
                ))));
  }
}
