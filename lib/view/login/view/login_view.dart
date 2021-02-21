import 'package:bettapinguis/view/home/view/home_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final databaseReference = FirebaseDatabase.instance.reference();

  void readData(){
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

  @override
  void initState() {
    // readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyHomePage(
      captainName: 'Fatih Atagun',
      shipName: 'Yaren',
      imo: '7412589',
    );
  }
}
