import 'package:flutter/material.dart';
import 'package:stard1stprojectrev0/layouts/tab_layout.dart';
import 'package:stard1stprojectrev0/screens/home_screen.dart';

class SubScreen extends StatefulWidget {
  static final String id = 'sub_screen';
  @override
  _SubScreenState createState() => _SubScreenState();
}

class _SubScreenState extends State<SubScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Padding(
      padding: const EdgeInsets.all(50.0),
      child: FlatButton(
        child: Text('Sub Screen'),
        onPressed: () {
          Navigator.pushNamed(context, HomeScreen.id);
        },
      ),
    )));
  }
}



