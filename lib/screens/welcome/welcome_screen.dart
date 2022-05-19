// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    // ส่งไปหน้า login
    Navigator.of(context).pushReplacementNamed('/login');
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {

    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "ระบบร้านค้าสำหรับทุกคน",
          body:
          "เริ่มต้นเปิดร้านกับเราได้เพียง 3 ขั้นตอนง่ายๆ",
          image: _buildImage('intro1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "เรียนรู้การใช้งานเบื้องต้น",
          body:
          "ดาวน์โหลดโหลดคู่มือการเรียนรู้ได้เลย",
          image: _buildImage('intro2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "เริ่มต้นกับเราได้แล้ววันนี้",
          body:
          "เพียงลงทะเบียนรับเสิทธิ์ฟรี",
          image: _buildImage('intro3.png'),
          decoration: pageDecoration,
        ),

      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      nextFlex: 0,
      skip: const Text('ข้าม'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('เริ่มใช้งาน', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),

    );
  }
}