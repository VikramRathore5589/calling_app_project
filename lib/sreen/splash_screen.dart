import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Center(
                      child: Image.asset(
                        'assetss/images/container.png',
                        width: 383,
                        height: 349,
                      )),
                  Center(
                      child: Image.asset(
                        'assetss/images/surefy.png',
                        width: 184,
                        height: 162.62,
                      )),
                ],
              ),
            ),
            Image.asset(
              'assetss/images/Communication Devices 1.gif',
              height: 110,
              width: 110,
            )
          ],
        ),
      ),
    );
  }
}