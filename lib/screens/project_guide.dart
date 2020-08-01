import 'package:flutter/material.dart';
import 'package:stard1stprojectrev0/screens/home_screen.dart';
import 'package:stard1stprojectrev0/screens/setting_screen.dart';

class ProjectGuide extends StatefulWidget {
  static final String id = 'project_guide';    // 프로젝트 가이드 페이지
  @override
  _ProjectGuideState createState() => _ProjectGuideState();
}

class _ProjectGuideState extends State<ProjectGuide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: FlatButton(
                child: Text('Project Guide'),
                onPressed: () {
                  Navigator.pushNamed(context, SettingScreen.id);
                },
              ),
            )));
  }
}
