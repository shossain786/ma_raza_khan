import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ma_raza_khan/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.scale(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.lightBlue,
          Colors.white70,
          Colors.lightBlue,
        ],
      ),
      childWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'بِسْمِ ٱللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ',
            style: TextStyle(
              fontSize: 40,
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black12,
                  offset: Offset(-4, -4),
                )
              ],
            ),
          ),
          const SizedBox(height: 100),
          SizedBox(
            height: 200,
            child: Image.asset("assets/images/splash.jpeg"),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 3900),
      animationDuration: const Duration(milliseconds: 2300),
      onAnimationEnd: () => debugPrint("On Scale End"),
      nextScreen: WelcomeScreen(),
    );
  }
}
