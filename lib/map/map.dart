import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {


  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {

  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  var data = Get.arguments;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(

          body: GoogleMap(
            markers: _createMarker(),
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(data[0],data[1]),
              zoom: 18.0,
            ),
          ),
        ),
      ),
    );
  }
  Set<Marker> _createMarker() {
    return {
      Marker(
          markerId: MarkerId("marker_1"),
          position: LatLng(data[0],data[1]),
          infoWindow: InfoWindow(title: data[2]),
          rotation: 25),

    };
  }

}
