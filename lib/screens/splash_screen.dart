import 'package:flutter/material.dart';
import 'package:rick_morty/screens/character_list_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CharacterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF272B33),
      body: SizedBox.expand(
          child: Image.asset(
        'assets/rick_morty_splash.jpg',
        fit: BoxFit.cover,
      )),
    );
  }
}
