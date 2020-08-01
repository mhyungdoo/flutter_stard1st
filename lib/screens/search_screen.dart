
import 'package:flutter/material.dart';
import 'package:stard1stprojectrev0/layouts/tab_layout.dart';
import 'package:stard1stprojectrev0/screens/home_screen.dart';

class SearchScreen extends StatefulWidget {
  static final String id = 'search_screen';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: FlatButton(
                child: Text('시작페이지 from Search Screen'),
                onPressed: () {
                  Navigator.pushNamed(context, TabLayout.id);
                },
              ),
            )));
  }
}
