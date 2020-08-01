import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'home_screen.dart';

class WriteScreen extends StatefulWidget {
  static final String id = 'write_screen';
  DocumentSnapshot document;

  WriteScreen({Key key, this.document}) : super(key: key);

  @override
  _WriteScreenState createState() => _WriteScreenState(document);
}

typedef void OnPickImageCallback(ImageSource source);

class _WriteScreenState extends State<WriteScreen> {
  DocumentSnapshot document;

  _WriteScreenState(this.document);

  String _retrieveDataError;
  PickedFile _imageFile;
  dynamic _pickImageError;
  bool write = false;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController textEditingController = TextEditingController();
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  bool showSpinner = false;
  var url = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (document != null) {
      textEditingController.text = document['title'];
      url = document['url'];
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _previewImage(BuildContext context) {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (url != null) {
      return Image.network(url,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width);
    } else if (_imageFile != null) {
      return Image.file(File(_imageFile.path), width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width);
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  void _onImageButtonPressed({BuildContext context}) async {
    await _displayPickImageDialog(context, (ImageSource source) async {
      try {
        final pickedFile = await _picker.getImage(
          source: source,
        );
        setState(() {
          _imageFile = pickedFile;
          url=null;
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    });
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('사진 선택'),
            actions: <Widget>[
              FlatButton(
                child: const Text('사진'),
                onPressed: () {
                  ImageSource source = ImageSource.gallery;
                  onPick(source);
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                  child: const Text('카메라'),
                  onPressed: () {
                    ImageSource source = ImageSource.camera;
                    onPick(source);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  void _uploadImageToStorage() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    // 프로필 사진을 업로드할 경로와 파일명을 정의. 사용자의 uid를 이용하여 파일명의 중복 가능성 제거
    StorageReference storageReference =
    _firebaseStorage.ref().child("photo/" + fileName);
    final File file = File(_imageFile.path);
    // 파일 업로드
    StorageUploadTask storageUploadTask = storageReference.putFile(file);
    // 파일 업로드 완료까지 대기
    await storageUploadTask.onComplete;
    // 업로드한 사진의 URL 획득
    String downloadURL = await storageReference.getDownloadURL();

    Firestore.instance.collection('stard').document().setData({
      'title': textEditingController.text,
      'author': 'MoonHD',
      'url': downloadURL,
      'lastUpdated': DateTime.now(),
    });
    textEditingController.clear();
    setState(() {
      _imageFile = null;
      showSpinner = false;
    });
    print('업로드 성공');
    Navigator.pushNamed(context, HomeScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0),
          child: ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              child: Icon(Icons.add_a_photo),
                              onPressed: () {
                                _onImageButtonPressed(context: context);
                              },
                            ),
                            FlatButton(
                              child: Icon(Icons.note_add),
                              onPressed: () {
                                setState(() {
                                  write = !write;
                                });
                              },
                            ),
                          ]),
                      _previewImage(context),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
                          enabled: write,
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.multiline,
                          maxLines: 2,
                          controller: textEditingController,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                write
                                    ? Icons.text_fields
                                    : Icons.do_not_disturb_alt,
                                color: Theme.of(context).primaryColor,
                              ),
                              focusColor: Theme.of(context).primaryColor,
                              hintText:
                              write ? "글을 작성해주세요" : "수정하려면 수정 버튼을 눌러주세요"),
                        ),
                      ),
                    ]),
              )
//              :  _previewImage(),
          ),
        ),
        floatingActionButton: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () async {
                    if (_imageFile == null) {
                      showDialog(
                          context: context,
                          builder: (v) {
                            return AlertDialog(
                              content: Text("사진이 없습니다"),
                              actions: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.pop(v);
                                  },
                                  color: Colors.red,
                                  child: Center(
                                    child: Text("OK"),
                                  ),
                                )
                              ],
                            );
                          });
                    } else {
                      setState(() {
                        showSpinner = true;
                      });
                      _uploadImageToStorage();
                    }
                  },
                  child: Icon(Icons.cloud_upload),
                ),
              ],
            )));
  }
}