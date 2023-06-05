import 'package:fingerprint_fe/screens/get_start_2.dart';
import 'package:flutter/material.dart';

class GetStart1Screen extends StatelessWidget {
  const GetStart1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'NOFP',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Image.asset('assets/pic1.png'),
            SizedBox(height: 150.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff444654),
              ),
              onPressed: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomPopup();
                  },
                );
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
    );
  }
}


class CustomPopup extends StatefulWidget {
  @override
  State<CustomPopup> createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Privacy Policy'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "*< NOFP >('http://10.0.2.2:5000'이하 'NOFP')*은(는) 「개인정보 보호법」 제30조에 따라 정보주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립·공개합니다.이 개인정보처리방침은 *2023*년 *1*월 *1*부터 적용됩니다.        **제1조(개인정보의 처리 목적)*< NOFP >('http://10.0.2.2:5000'이하 'NOFP')*은(는) 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며 이용 목적이 변경되는 경우에는 「개인정보 보호법」 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.**\n2. 개인영상정보죄의 예방 및 수사 등을 목적으로 개인정보를 처리합니다.\n**제2조(개인정보의 처리 및 보유 기간)**\n      ① *< NOFP >*은(는) 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의받은 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다.\n② 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.\n1.<개인영상정보>\n- <개인영상정보>와 관련한 개인정보는 수집.이용에 관한 동의일로부터<지체없이 파기>까지 위 이용목적을 위하여 보유.이용됩니다.\n- 보유근거 : 이미지 분석\n- 관련법령 : 표시/광고에 관한 기록 : 6개월",
            ),
            CheckboxListTile(
              title: Text('Agree'),
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = value!;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isChecked
          ? () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => GetStart2Screen()));
          }
          : null,
          child: const Text('Close'),
        ),
      ],
    );
  }
}