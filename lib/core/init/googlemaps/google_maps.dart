import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsView extends StatefulWidget {
  @override
  _GoogleMapsViewState createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> {

  static final CameraPosition _shipLocation = CameraPosition(
    target: LatLng(40.37038345471841, 27.953930036762397), zoom: 12);
  BitmapDescriptor favIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _shipLocation,
        onMapCreated: (map) async {
          await _createMarkerImageFromAssets(context);
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
    return <Marker>[
      Marker(
        markerId: MarkerId("1"),
        position: _shipLocation.target,
        icon: favIcon,
        zIndex: 10,
        infoWindow: InfoWindow(title: "My Ship"),
      ),
    ].toSet();
  }
}
