import 'package:flutter/material.dart';
import 'package:flutterscale/themes/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  // สร้างตัวแปรสำหรับไว้ผูกกับฟอร์ม
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontSize: 20, color: inputTextColor),
                      decoration: const InputDecoration(
                        labelText: 'Fullname',
                        hintText: 'ป้อนชื่อ-สกุล',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: inputTextColor
                        ),
                        icon: Icon(Icons.person, size: 24,)
                      ),
                    ),
                    TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontSize: 20, color: inputTextColor),
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        hintText: 'ป้อนชื่อผู้ใช้',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: inputTextColor
                        ),
                        icon: Icon(Icons.person, size: 24,)
                      ),
                    ),
                    TextFormField(
                      autofocus: false,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontSize: 20, color: inputTextColor),
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'ป้อนรหัสผ่าน',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: inputTextColor
                        ),
                        icon: Icon(Icons.lock, size: 24,)
                      ),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      width: 280,
                      child: ElevatedButton(
                        onPressed: (){}, 
                        child: const Text('ลงทะเบียน')
                      ),
                    ),
                    const SizedBox(height: 40,),
                    const Text('เป็นสมาชิกอยู่แล้ว ?'),
                    TextButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacementNamed('/login');
                      }, 
                      child: const Text('เข้าสู่ระบบ')
                    )
                  ],
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}