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

  void updateData(){
    databaseReference.child(widget.imo).update({
      'Anlik Avlanma Derinligi': _depth,
      'Anlik Su Sicakligi': _temperature,
      'Anlik Konum': '40.37038345471841, 27.953930036762397',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: true,
            title: Text('Betta Pinguis'),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              /* Children */
              [
                Container(
                  width: dynamicWidth(1),
                  height: dynamicHeight(0.45),
                  child: GoogleMapsView(),
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
              ],
            ),
          ),
          SliverGrid.count(
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 2.2,
            crossAxisCount: 2,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 1, 0, 1),
                child: ListTile(
                  leading: Icon(Icons.anchor, size: 48),
                  title: Text(widget.shipName),
                  subtitle: Text('Gemi'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 1, 40, 1),
                child: ListTile(
                  leading: Icon(Icons.alternate_email, size: 48),
                  title: Text(widget.imo),
                  subtitle: Text('IMO'),
                ),
              ),
            ],
          ),
          SliverGrid.count(
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.2,
            crossAxisCount: 2,
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
