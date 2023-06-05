import 'package:fingerprint_fe/screens/get_start_3.dart';
import 'package:flutter/material.dart';

class GetStart2Screen extends StatelessWidget {
  const GetStart2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: Image.asset('assets/pic2.png'),
              ),
              const SizedBox(height: 60.0),
              const Text(
                'Fingerprint in Selfie',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height:30.0),
              Container(
                margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: const Text(
                  'Are you aware that someone can extract and duplicate your FINGERPRINT from a photo?',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 80.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff444654),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const GetStart3Screen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Next'), // 텍스트 설정
                    SizedBox(width: 8),
                    Icon(Icons.navigate_next), // 아이콘 설정
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
