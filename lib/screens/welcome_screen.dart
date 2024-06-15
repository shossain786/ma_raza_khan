import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:ma_raza_khan/screens/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final pages = [
    PageViewModel(
      pageColor: const Color(0xFF03A9F4),
      bubble: Image.asset('assets/images/jamia1.png'),
      body: const Text(
        'Madrassa Building View, a buitiful and place in the world.',
      ),
      title: const Text(
        'JAMIA M.A RAZA KHAN',
        textAlign: TextAlign.center,
      ),
      titleTextStyle: const TextStyle(
        fontFamily: 'MyFont',
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            color: Colors.black26,
            offset: Offset(-4, -4),
          )
        ],
      ),
      bodyTextStyle: const TextStyle(
        fontFamily: 'MyFont',
        color: Colors.white,
      ),
      mainImage: ExtendedImage.asset(
        'assets/images/jamia1_1.jpeg',
        fit: BoxFit.fill,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(
          Radius.circular(30.0),
        ),
        border: Border.all(
          width: 2,
          color: Colors.white,
        ),
      ),
    ),
    PageViewModel(
      pageColor: const Color(0xFF8BC34A),
      iconImageAssetPath: 'assets/images/jamia2.jpeg',
      body: const Text(
        'A beautiful hostel campus for talib e elm',
      ),
      title: const Text(
        'HOSTEL STUDY AREA',
        textAlign: TextAlign.center,
      ),
      mainImage: ExtendedImage.asset(
        'assets/images/jamia2.jpeg',
        alignment: Alignment.center,
        fit: BoxFit.fill,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(
          Radius.circular(30.0),
        ),
        border: Border.all(
          width: 2,
          color: Colors.white,
        ),
      ),
      titleTextStyle: const TextStyle(
        fontFamily: 'MyFont',
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            color: Colors.black26,
            offset: Offset(-4, -4),
          )
        ],
      ),
      bodyTextStyle: const TextStyle(
        fontFamily: 'MyFont',
        color: Colors.white,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => IntroViewsFlutter(
        pages,
        showNextButton: true,
        showBackButton: true,
        onTapDoneButton: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        },
        pageButtonTextStyles: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
