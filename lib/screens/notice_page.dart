import 'package:flutter/material.dart';


class NoticePage extends StatefulWidget {
  static final String id = 'notice_page';  // 이 페이지의 id를 지정함. 공지사항 페이지.

  @override
  _NoticePageState createState() => _NoticePageState(); //하위 클래스 이름 정의
}

class _NoticePageState extends State<NoticePage> {
  //Class 이름과 동일하게 SettingScreen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back'),
        backgroundColor: Colors.grey[800],
      ),
      body: Container(child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Text ('공지사항 페이지'),
      ))
    );
  }
}
