import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsView extends StatefulWidget {
  final String imo;

  const GoogleMapsView({Key key, this.imo}) : super(key: key);

  @override
  _GoogleMapsViewState createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> {

  final databaseReference = FirebaseDatabase.instance.reference();

  CameraPosition _shipLocation = CameraPosition(
      target: LatLng(40.37038345471841, 27.953930036762397), zoom: 12);

  BitmapDescriptor favIcon;

  List<Marker> markers = <Marker>[];

  void updateData(LatLng value) {
    databaseReference.child(widget.imo).update({
      'Anlik Konum': '${value.latitude}, ${value.longitude}',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _shipLocation,
        onMapCreated: (map) async {
          await _createMarkerImageFromAssets(context);
          markers.add(Marker(
            markerId: MarkerId("1"),
            position: _shipLocation.target,
            icon: favIcon,
            zIndex: 10,
            infoWindow: InfoWindow(title: "My Ship"),
          ));
          setState(() {});
        },
        onTap: (value) {
          markers.add(Marker(
            markerId: MarkerId('1'),
            position: value,
            icon: favIcon,
            zIndex: 10,
            infoWindow: InfoWindow(title: "My Ship"),
          ));
          updateData(value);
          setState(() {});
        },
        markers: _creatMarker(),
      ),
    );
  }

  Future<void> _createMarkerImageFromAssets(BuildContext context) async {
    if (favIcon == null) {
      final ImageConfiguration imageConfiguration = createLocalImageConfiguration(context);
      var bitmap = await BitmapDescriptor.fromAssetImage(imageConfiguration, "assets/icons/fishing-boat-64.png");
      favIcon = bitmap;
      setState(() {});
    }
  }

  Set<Marker> _creatMarker() {
    return markers.toSet();
  }
}
