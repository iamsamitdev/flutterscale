import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterscale/services/rest_api.dart';
import 'package:flutterscale/themes/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // สร้างตัวแปรสำหรับไว้ผูกกับฟอร์ม
  final formKey = GlobalKey<FormState>();

  // สร้างตัวแปรไว้รับค่าจากฟอร์ม
  late String _username, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
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
                        style: const TextStyle(
                            fontSize: 20, color: inputTextColor),
                        decoration: const InputDecoration(
                            labelText: 'Username',
                            hintText: 'ป้อนชื่อผู้ใช้',
                            hintStyle:
                                TextStyle(fontSize: 16, color: inputTextColor),
                            icon: Icon(
                              Icons.person,
                              size: 24,
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'กรุณาป้อนชื่อผู้ใช้ก่อน';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _username = value.toString().trim();
                        },
                      ),
                      TextFormField(
                        autofocus: false,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                            fontSize: 20, color: inputTextColor),
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            hintText: 'ป้อนรหัสผ่าน',
                            hintStyle:
                                TextStyle(fontSize: 16, color: inputTextColor),
                            icon: Icon(
                              Icons.lock,
                              size: 24,
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'กรุณาป้อนรหัสผ่านก่อน';
                          } else if (value.length < 4) {
                            return 'รหัสผ่านต้องไม่น้อยกว่า 4 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _password = value.toString().trim();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 280,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();

                                // print(_username);
                                // print(_password);

                                // เรียกใช้ LoginAPI
                                var response = await CallAPI().loginAPI(
                                  {
                                    "username": _username,
                                    "password": _password
                                  }
                                );

                                var body = json.decode(response.body);

                                if (body['status'] == 'success' && 
                                    body['data']['status'] == '1') {
                                  // สร้าง Object แบบ SharedPreferences
                                  SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();

                                  // เก็บค่าที่ต้องการลงในตัวแปรแบบ SharedPreferences
                                  sharedPreferences.setInt('userStep', 1);
                                  sharedPreferences.setString(
                                    'userName', _username
                                  );
                                  sharedPreferences.setString(
                                    'fullName', body['data']['fullname']
                                  );
                                  sharedPreferences.setString(
                                    'imgProfile', body['data']['img_profile']
                                  );

                                  // ส่งไปหน้า HomeScreen
                                  Navigator.of(context).pushReplacementNamed('/dashboard');
                                 } else {
                                  AlertDialog alert = AlertDialog(
                                    title: const Text('มีข้อผิดพลาด'),
                                    content:
                                        const Text('ข้อมูลเข้าระบบไม่ถูกต้อง'),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'))
                                    ],
                                  );

                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      });
                                }
                              }
                            },
                            child: const Text('เข้าสู่ระบบ')),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text('ยังไม่เป็นสมาชิก ?'),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/register');
                          },
                          child: const Text('ลงทะเบียน'))
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
