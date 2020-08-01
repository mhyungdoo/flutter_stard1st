import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stard1stprojectrev0/screens/write_screen.dart'; // 파이어베이스 기능 import 추가

class DbScreen extends StatefulWidget {
  static final String id = 'db_screen'; // 이 페이지의 id를 지정함.

  @override
  _DbScreenState createState() => _DbScreenState(); //하위 클래스 이름 정의
}

class _DbScreenState extends State<DbScreen> {
  //Class 이름과 동일하게 SettingScreen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Back'),
          backgroundColor: Colors.grey[800],
        ),
        body: StreamBuilder<QuerySnapshot>(
          // 여기서 부터 DB 관련 코딩임.
          stream: Firestore.instance.collection('stard')
              .orderBy('lastUpdated', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading…');
              default:
                return new ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {

                        String id = document.documentID;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
                        height: 50,
                        child: ListTile(
                          leading: Image.network(document['url']),
                          title: Text(document['title']),
                          subtitle: Text(document['author'] +
                              " " +
                              "최근수정:" +
                              document['lastUpdated']
                                  .toDate()
                                  .toString()
                                  .substring(0, 10)),
                          onTap: () {
                            print(document['id']);
                          },
                          onLongPress: (){
                           showAlertDialog(context, document);
                          },
                          isThreeLine: true,
                        ),
                      ),
                    );
                  }).toList(),
                );
            }
          },
        ),


        floatingActionButton: Padding(
            // 여기서부터 플로팅 버튼을 통해 DB 추가, 삭제, 수정 기능 추가
            padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FloatingActionButton.extended(
                  heroTag: "btn1", // heroTag id가 없으면 본 화면 들어올 때 에러가 발생함.
                  onPressed: () {
                    Firestore.instance
                        .collection('stard')
                        .document() // 각자가 생성한 DB명을 작성함. 여기서는 'stard'
                        .setData({
                      'title': '테스트0705',
                      'author': 'MoonHD',
                      'url':
                          'http://blogfiles.naver.net/data43/2009/4/10/58/result_2009_3_5_20_0_29_531_2-hoonjean.jpg',
                      'lastUpdated': DateTime.now()
                    });
                  },
                  label: Text('C'),
                  icon: Icon(Icons.move_to_inbox),
                ),
                FloatingActionButton.extended(
                  heroTag: "btn2",
                  onPressed: () {},
                  label: Text('R'),
                  icon: Icon(Icons.move_to_inbox),
                ),
                FloatingActionButton.extended(
                  heroTag: "btn3",
                  onPressed: () {},
                  label: Text('U'),
                  icon: Icon(Icons.move_to_inbox),
                ),
                FloatingActionButton.extended(
                  heroTag: "btn4",
                  onPressed: () {},
                  label: Text('D'),
                  icon: Icon(Icons.move_to_inbox),
                ),
              ],
            )));
  }
}

void showAlertDialog(BuildContext context, DocumentSnapshot document) async {
  String result = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(document['title']),
          content: Text("메뉴를 선택해주세요"),
          actions: <Widget>[
            FlatButton(
              child: Text('수정'),
              onPressed: () {
                Navigator.pop(context, "modify");
              },
            ),
            FlatButton(
              child: Text('삭제'),
              onPressed: () {
                Navigator.pop(context, "delete");
              },
            ),
          ],
        );
      }

  );

  if (result == "modify") {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WriteScreen(document: document),   // 수정을 받는 WriteScreen 화면으로 넘어감.
      ));




//    Firestore.instance
 //       .collection('stard') //firebase 문서이름
 //       .document(document.documentID)
 //       .updateData({
 //           'title': "[m]"+document['title']
 //   });


  }

  else if (result == "delete") {
    Firestore.instance
        .collection('stard') //firebase 문서이름
        .document(document.documentID)
        .delete();
  }
  }
