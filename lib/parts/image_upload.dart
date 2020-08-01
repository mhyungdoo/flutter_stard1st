import 'package:flutter/material.dart';


class ImageUpload {

  Future<void> pickImageDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('사진 선택'),
            actions: <Widget>[
              FlatButton(
                child: const Text('앨범'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                  child: const Text('카메라'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
}

