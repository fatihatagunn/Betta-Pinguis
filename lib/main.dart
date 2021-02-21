import 'package:bettapinguis/core/init/googlemaps/google_mapscircle.dart';
import 'package:bettapinguis/view/home/view/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Betta Pinguis',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF004AAD, {
          50: Color(0xFFE0E9F5),
          100: Color(0xFFB3C9E6),
          200: Color(0xFF80A5D6),
          300: Color(0xFF4D80C6),
          400: Color(0xFF2665B9),
          500: Color(0xFF004AAD),
          600: Color(0xFF0043A6),
          700: Color(0xFF003A9C),
          800: Color(0xFF003293),
          900: Color(0xFF002283),
        }),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GMap()/*MyHomePage(
        captainName: 'Melih',
        shipName: 'Hande',
        imo: '6666666',
      ),*/
    );
  }
}
