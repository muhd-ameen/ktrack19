import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pandamus/initialPages/home.dart';
import 'package:pandamus/initialPages/login_screen.dart';
import 'package:pandamus/initialPages/otp_screen1.dart';
import 'package:pandamus/screens/splash-screen.dart';
import 'package:pandamus/screens/utils/user_simple_prefereences.dart';
import 'initialPages/onbording.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserSimplePreferences.init();
  runApp(MyApp());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/otpScreen': (BuildContext ctx) => OtpScreen(),
        '/homeScreen': (BuildContext ctx) => HomeScreen(),
        '/Onbording': (BuildContext ctx) => Onbording(),
        '/login': (BuildContext ctx) => LoginScreen(),
      },
    );
  }
}
