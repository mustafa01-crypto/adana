import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  double x;
  double y;
  String title;


  Map({required this.x, required this.y,required this.title});

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {

  Completer<GoogleMapController> _controller = Completer();


  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }



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
              target: LatLng(widget.x,widget.y),
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
          position: LatLng(widget.x,widget.y),
          infoWindow: InfoWindow(title: widget.title),
          rotation: 25),

    };
  }

}
