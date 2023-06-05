import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../utils/before_and_after.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  BeforeAndAfter? _beforeAndAfter;

  Future save_Img(List<int> after) async {
    // 이미지 파일로 저장
    final appDir = await getTemporaryDirectory();
    File imageFile = File('${appDir.path}/blurred.jpg');
    await imageFile.writeAsBytes(after);
    await ImageGallerySaver.saveImage(imageFile.readAsBytesSync());
  }

  @override
  Widget build(BuildContext context) {
    _beforeAndAfter = ModalRoute.of(context)!.settings.arguments as BeforeAndAfter;
    return Scaffold(
      backgroundColor: const Color(0xff343541),
      body: Container(
        color: const Color(0xff000000),
        margin: const EdgeInsets.fromLTRB(0, 150, 0, 170),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Before',
                        style: TextStyle(fontSize: 20, color: Color(0xffd6d6d6)),
                      ),
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        child: _beforeAndAfter != null
                            ? Hero(
                          tag: 'imagetag1',
                          child: Image.file(
                            _beforeAndAfter!.before,
                          ),
                        )
                            : null,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/toFullScreen', arguments: _beforeAndAfter);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'After',
                          style: TextStyle(fontSize: 20, color: Color(0xffd6d6d6)),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          child: _beforeAndAfter != null
                              ? Hero(
                            tag: 'imagetag2',
                            child: Image.memory(
                                _beforeAndAfter!.red
                            ),
                          )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: const Alignment(0.55, 0), // 가로 3/4 지점에 아이콘 배치
              child: const Icon(
                Icons.touch_app_rounded,
                size: 30,
                color: Color(0xffd6d6d6),
              ),
            ),
            Container(
              alignment: const Alignment(0.65, 0), // 가로 3/4 지점에 아이콘 배치
              child: const Text(
                'Full Screen',
                style: TextStyle(fontSize: 15, color: Color(0xffd6d6d6)),
              ),
            ),
            const SizedBox(height: 30,),
            Center(
              child: _beforeAndAfter != null
                  ? ElevatedButton.icon(
                onPressed: () {
                  save_Img(_beforeAndAfter!.after);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Image has been saved successfully."),
                    duration: Duration(seconds: 2),
                  ));
                },
                icon: const Icon(Icons.save_alt_rounded), // 아이콘 설정
                label: const Text('Save Image'), // 텍스트 설정
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff444654), // 버튼의 배경색을 빨간색으로 설정
                ),
              )
                  : null,
            ),
            const SizedBox(height: 20,),
            const Text(
              "Since we are using AI, the detection may not work well in some cases.",
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.white,
              ),
            ),
            const Text(
              "If the detection didn't work well, try using a different image.",
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FullScreenImageScreen extends StatelessWidget {
  BeforeAndAfter? _beforeAndAfter;

  @override
  Widget build(BuildContext context) {
    _beforeAndAfter = ModalRoute.of(context)!.settings.arguments as BeforeAndAfter;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        child: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(20),
          minScale: 0.5,
          maxScale: 5.0,
          child: Center(
            child: Hero(
              tag: 'imageTag2',
              child: Image.memory(
                  _beforeAndAfter!.after
              ),
            ),
          ),
        ),
      ),
    );
  }
}