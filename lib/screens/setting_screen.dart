import 'package:flutter/material.dart';
import 'package:stard1stprojectrev0/screens/db_screen.dart';
import 'package:stard1stprojectrev0/screens/home_screen.dart';
import 'package:stard1stprojectrev0/screens/notice_page.dart';
import 'package:stard1stprojectrev0/screens/project_guide.dart';

class SettingScreen extends StatefulWidget {
  static final String id = 'setting_screen';

  @override
  _SettingScreenState createState() => _SettingScreenState(); //하위 클래스 이름 정의
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        children: <Widget>[
          FlatButton(
            child: Text('공지사항'),
            color: Colors.green,
            onPressed: () {
              Navigator.pushNamed(context, NoticePage.id);
            },
          ),

       RaisedButton(
            child: Text('DB Screen'),
            onPressed: (){
              Navigator.pushNamed(context, DbScreen.id);
            },

          ),

        ],
      ),
    )));
  }
}
