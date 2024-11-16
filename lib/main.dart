import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; //import splass screen
import 'screens/login_screen.dart'; // Import halaman login Anda

void main() {
  runApp(SamsLaundryApp());
}

class SamsLaundryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sam\'s Laundry',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreenWithDelay(),
    );
  }
}

class SplashScreenWithDelay extends StatefulWidget {
  @override
  _SplashScreenWithDelayState createState() => _SplashScreenWithDelayState();
}

class _SplashScreenWithDelayState extends State<SplashScreenWithDelay> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen()), // Pindah ke halaman login
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
