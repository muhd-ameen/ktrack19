import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pandamus/initialPages/home.dart';
import 'package:pandamus/initialPages/onbording.dart';
import 'package:pandamus/screens/donate.dart';
import 'package:pandamus/screens/payment.dart';
import 'initialPages/otp_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
