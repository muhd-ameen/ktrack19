import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pandamus/initialPages/home.dart';
import 'package:pandamus/initialPages/login_screen.dart';
import 'package:pandamus/screens/emergency_contacts.dart';
import 'package:pandamus/screens/profile.dart';
import 'package:pandamus/screens/utils/user_simple_prefereences.dart';
import 'package:pandamus/vaccine/vaccine_slot.dart';
import 'initialPages/otp_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserSimplePreferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomeScreen(),
      routes: <String, WidgetBuilder>{
        '/otpScreen': (BuildContext ctx) => OtpScreen(),
        '/homeScreen': (BuildContext ctx) => HomeScreen(),
      },
    );
  }
}
