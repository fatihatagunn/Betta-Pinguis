import 'package:bettapinguis/core/base/state/base_state.dart';
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
                  height: dynamicHeight(0.3),
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'Google Map',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: dynamicWidth(0.4),
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
                    modifier: (value) {
                      final roundedValue = value.ceil().toInt().toString();
                      return '$roundedValue °C';
                    },
                  ),
                ),
                min: 10,
                max: 100,
                initialValue: 14,
                onChange: (value) {
                  print(value);
                },
              ),
              SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  customWidths: CustomSliderWidths(progressBarWidth: 10),
                  infoProperties: InfoProperties(
                    modifier: (value) {
                      final roundedValue = value.ceil().toInt().toString();
                      return '$roundedValue m.';
                    },
                  ),
                ),
                min: 10,
                max: 100,
                initialValue: 14,
                onChange: (value) {
                  print(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
