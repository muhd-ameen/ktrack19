import 'package:flutter/material.dart';
import 'package:pandamus/initialPages/home.dart';
import 'package:pandamus/vaccine/get_vaccinated.dart';
import 'package:pandamus/vaccine/vaccine_registration.dart';
import 'package:pandamus/vaccine/vaccine_slot.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: GetVaccinated(),
    );
  }
}
