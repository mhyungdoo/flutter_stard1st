import 'package:flutter/material.dart';
import 'package:stard1stprojectrev0/screens/db_screen.dart';
import 'package:stard1stprojectrev0/screens/home_screen.dart';
import 'package:stard1stprojectrev0/screens/login_page.dart';
import 'package:stard1stprojectrev0/screens/notice_page.dart';
import 'package:stard1stprojectrev0/screens/project_guide.dart';
import 'package:stard1stprojectrev0/screens/search_screen.dart';
import 'package:stard1stprojectrev0/screens/setting_screen.dart';
import 'package:stard1stprojectrev0/screens/sub_screen.dart';
import 'package:stard1stprojectrev0/screens/map_screen.dart';
import 'package:stard1stprojectrev0/screens/write_screen.dart';
import 'layouts/tab_layout.dart'; //map_screen.dart 파일의 함수를 가져온다.

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STARD #1 Project',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        // Define the default font family.
        fontFamily: 'Noto Sans',
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {        //라우트는 해당 화면으로 가라는 의미
        HomeScreen.id: (context) => HomeScreen(),  //시작하는 HomeScreen 함수는 있어야 함.
        SearchScreen.id: (context) => SearchScreen(),
        WriteScreen.id: (context) => WriteScreen(),
        MapScreen.id: (context) => MapScreen(), //MapScreen Class는 map_screen.dart에 정의함, 이 코드는 없어도 정상 실행됨.
        SettingScreen.id: (context) => SettingScreen(),
        SubScreen.id: (context) => SubScreen(),
        DbScreen.id: (context) => DbScreen(),
        NoticePage.id: (context) => NoticePage(),
        TabLayout.id: (context) => TabLayout(),  //이동하려는 페이지는 모두 여기 main에 있어야 함.
        ProjectGuide.id: (context) => ProjectGuide(),//새로운 페이지를 만들어 줄 때마다 여기에 불러와줘야 함.
        LoginPage.id: (context) => LoginPage(),
      },
    );
  }
}
