import 'package:fingerprint_fe/utils/before_and_after.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final ImagePicker _picker = ImagePicker();
  File? _image;
  bool showSpinner = false;

  Future selectImg() async {
    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        _image = File(img.path);
      });
    }
  }

  Future send_get_Img() async {
    setState(() {
      showSpinner = true;
    });
    // 서버 엔드포인트 URL
    // String aws_server = "43.201.214.134";
    String local_server = "10.0.2.2";

    String url = "http://$local_server:5000";
    String imageUrl =  "http://$local_server:5000/image";

    // 이미지 파일을 읽어옴
    File imageFile = _image!;
    List<int> imageBytes = await imageFile.readAsBytes();

    // HTTP POST 요청 생성
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // 이미지 파일 추가
    var multipartFile = http.MultipartFile.fromBytes('image', imageBytes, filename: 'myImage.jpg');
    request.files.add(multipartFile);

    // 요청 보내고 응답 처리
    var response = await request.send();
    if (response.statusCode == 200) {
    } else {
      print('이미지 업로드 실패: ${response.statusCode}');
    }

    // HTTP GET 요청 보내기
    Future.delayed(const Duration(milliseconds: 1000), () async {
      // 1초 후에 실행될 작업을 여기에 작성합니다.
      await http.get(Uri.parse(imageUrl)).then((response) async {
        if (response.statusCode == 200) {
          // 이미지 데이터 받기
          var imageData_blurred = response.bodyBytes;
          var imageData_red_line;

          await http.get(Uri.parse("$imageUrl/red")).then((response) async {
            if (response.statusCode == 200) {
              // 이미지 데이터 받기
              imageData_red_line = response.bodyBytes;
            }
          }).catchError((error) {
            print('오류 발생: $error');
            setState(() {
              showSpinner = false;
            });
          });

          if (imageData_red_line != null) {
            setState(() {
              showSpinner = false;
            });
            Navigator.of(context).pushNamed('/toResultScreen', arguments: BeforeAndAfter(before: _image!, after: imageData_blurred, red: imageData_red_line));
          }
        }
      }).catchError((error) {
        print('오류 발생: $error');
        setState(() {
          showSpinner = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff343541),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NOFP',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              margin: const EdgeInsets.all(15.0),
              width: 300,
              height: 300,
              color: const Color(0xffDADADA),
              child: _image != null
                  ? Image.file(
                _image!,
                fit: BoxFit.cover,
              )
                  : const Icon(Icons.camera_alt_outlined),
            ),
            const SizedBox(height: 30,),
            Center(
              child: _image != null
                  ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff444654),
                ),
                onPressed: send_get_Img,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Send Image'), // 텍스트 설정
                    SizedBox(width: 8),
                    Icon(Icons.send_rounded), // 아이콘 설정
                  ],
                ),
              )
                  : ElevatedButton.icon(
                onPressed: selectImg,
                icon: const Icon(Icons.add), // 아이콘 설정
                label: const Text('New Image'), // 텍스트 설정
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff444654),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _image != null
          ? FloatingActionButton(
        onPressed: () {
          setState(() {_image = null;});
        },
        backgroundColor: const Color(0xff19c37d),
        child: const Icon(
          Icons.restart_alt,
        ),
      )
          : null,
    );
  }
}

