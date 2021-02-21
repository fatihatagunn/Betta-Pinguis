import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMap extends StatefulWidget {
  GMap({Key key}) : super(key: key);

  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  Set<Circle> _circles = HashSet<Circle>();
  bool _showMapStyle = false;

  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
    _setCircles();
  }

  void _setMarkerIcon() async {
    _markerIcon =
    await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/noodle_icon.png');
  }



  void _setCircles() {
    _circles.add(
      Circle(
          circleId: CircleId("0"),
          center: LatLng(40.39888838367925, 27.923902075493235),
          radius: 1000,
          strokeWidth: 2,
          fillColor: Color.fromRGBO(255, 0, 0, 0.5)),
    );
    _circles.add(
      Circle(
          circleId: CircleId("1"),
        center: LatLng(40.453720443278364, 28.0731244027283),
      radius: 1000,
      strokeWidth: 2,
      fillColor: Color.fromRGBO(255, 0, 0, 0.5)),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Av Haritası')),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(40.40171993810886, 27.995151537613648),
              zoom: 12,
            ),
            circles: _circles,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}