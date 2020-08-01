import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stard1stprojectrev0/screens/home_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapScreen extends StatefulWidget {
  static final String id = 'map_screen';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final point = CameraPosition(
    target: LatLng(37.4980345, 127.0278163), //특정 위치를 찍으면 해당 주소를 보여줌. 구글 지도에서 확인 가능.
    zoom: 18.0,
  );

  static final toPoint = CameraPosition(
    target: LatLng(36.4980345, 127.0278163), //특정 위치를 찍으면 해당 주소를 보여줌. 구글 지도에서 확인 가능.
    zoom: 18.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: point,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(70.0, 0, 35.0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton.extended(
                onPressed: _goToHome,
                label: Text('Home'),
                icon: Icon(Icons.directions_walk),
            ),
            FloatingActionButton.extended(
              onPressed: _goToLake,
              label: Text('go to Lake'),
              icon: Icon(Icons.directions_boat),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _goToHome() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(point));
          }

  Future<void> _goToLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(toPoint));
  }
}
