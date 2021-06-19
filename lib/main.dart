import 'package:flutter/material.dart';
import 'package:pandamus/initialPages/home.dart';
import 'package:pandamus/initialPages/onbording.dart';
import 'package:pandamus/initialPages/otp_screen.dart';
import 'package:pandamus/screens/donation.dart';
import 'package:pandamus/screens/emergency_contacts.dart';
import 'package:pandamus/screens/welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Onbording(),
    );
  }
}
