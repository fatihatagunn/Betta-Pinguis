import 'package:bettapinguis/core/base/state/base_state.dart';
import 'package:bettapinguis/core/init/googlemaps/google_maps.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.captainName, this.shipName, this.imo}) : super(key: key);

  final String captainName;
  final String shipName;
  final String imo;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends BaseState<MyHomePage> {
  final databaseReference = FirebaseDatabase.instance.reference();

  String _depth = 10.toString();
  String _temperature = 9.toString();

  void updateData() {
    databaseReference.child(widget.imo).update({
      'depth': _depth,
      'temperature': _temperature,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Betta Pinguis'),
      ),
      body: Column(
        children: [
          Container(
            height: dynamicHeight(0.45),
            child: GoogleMapsView(imo: widget.imo),
          ),
          Center(
            child: Container(
              width: dynamicWidth(0.5),
              child: ListTile(
                leading: Icon(Icons.account_circle_rounded, size: 48),
                title: Text(widget.captainName),
                subtitle: Text('Kaptan'),
              ),
            ),
          ),
          Row(
            children: [
              Spacer(),
              Expanded(
                flex: 3,
                child: ListTile(
                  leading: Icon(Icons.anchor, size: 48),
                  title: Text(widget.shipName),
                  subtitle: Text('Gemi'),
                ),
              ),
              Expanded(
                flex: 3,
                child: ListTile(
                  leading: Icon(Icons.alternate_email, size: 48),
                  title: Text(widget.imo),
                  subtitle: Text('IMO'),
                ),
              ),
              Spacer(),
            ],
          ),
          Divider(thickness: 0, height: 40, indent: dynamicWidth(0.4), endIndent: dynamicWidth(0.4)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  customWidths: CustomSliderWidths(progressBarWidth: 10),
                  infoProperties: InfoProperties(
                    mainLabelStyle: TextStyle(color: Colors.blueGrey, fontSize: 32),
                    bottomLabelStyle: TextStyle(color: Colors.blueGrey, fontSize: 24),
                    bottomLabelText: '\nSu Sıcaklığı',
                    modifier: (value) {
                      final roundedValue = value.ceil().toInt().toString();
                      return '$roundedValue °C';
                    },
                  ),
                  customColors: CustomSliderColors(
                    trackColor: Colors.blueGrey,
                    progressBarColors: [
                      Color.fromRGBO(244, 67, 54, 1.0),
                      Color.fromRGBO(33, 150, 243, 1.0),
                    ],
                  ),
                ),
                min: 0,
                max: 35,
                initialValue: 9,
                onChange: (value) {
                  print(value);
                  _temperature = value.toString();
                  updateData();
                },
              ),
              SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  customWidths: CustomSliderWidths(progressBarWidth: 10),
                  infoProperties: InfoProperties(
                    mainLabelStyle: TextStyle(color: Colors.blueGrey, fontSize: 32),
                    bottomLabelStyle: TextStyle(color: Colors.blueGrey, fontSize: 24),
                    bottomLabelText: '\nDerinlik',
                    modifier: (value) {
                      final roundedValue = value.ceil().toInt().toString();
                      return '$roundedValue m.';
                    },
                  ),
                  customColors: CustomSliderColors(
                    trackColor: Colors.blueGrey,
                    progressBarColors: [
                      Color.fromRGBO(76, 175, 80, 1.0),
                      Color.fromRGBO(76, 175, 80, 1.0),
                      Color.fromRGBO(255, 193, 7, 1.0),
                      Color.fromRGBO(244, 67, 54, 1.0),
                    ],
                  ),
                ),
                min: 0,
                max: 80,
                initialValue: 10,
                onChange: (value) {
                  print(value);
                  _depth = value.toString();
                  updateData();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
