
import 'package:fingerprint_fe/screens/get_start_1.dart';
import 'package:fingerprint_fe/screens/home_screen.dart';
import 'package:fingerprint_fe/screens/result_screen.dart';

import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xffd6d6d6), // 메인 색상 설정
        scaffoldBackgroundColor: const Color(0xffd6d6d6),
      ),
      title: 'FingerPrint',
      initialRoute: '/',
      routes: {
        '/': (context) =>  const GetStart1Screen(),
        '/toHomeScreen': (context) => const HomeScreen(),
        '/toResultScreen': (context) => const ResultScreen(),
        '/toFullScreen': (context) => FullScreenImageScreen(),
      },
    );
  }
}



