// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutterscale/models/UserModel.dart';
import 'package:flutterscale/services/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // สร้าง Sharedprefference Object
  late SharedPreferences sharedPreferences;

  // ตัวแปรเก็บ _fullname , _username, _avatar
  String? _fullname, _username, _avatar;

  // เรียกใช้งาน UserMode
  UserModel? userModel;

  // สร้างฟังก์ชัน readUserProfile()
  readUserProfile() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var response =
        await CallAPI().getProfile(sharedPreferences.getString('userID'));
    setState(() {
      userModel = response;
      _fullname = userModel!.fullname;
      _username = userModel!.username;
      _avatar = userModel!.imgProfile;
    });
  }

  @override
  void initState() {
    super.initState();
    readUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/mybg.jpeg'),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.white,
                  child: _avatar != null
                      ? CircleAvatar(
                          radius: 46.0,
                          backgroundImage: NetworkImage(
                              'https://www.itgenius.co.th/sandbox_api/mrta_flutter_api/public/images/profile/' +
                                  _avatar!),
                        )
                      : CircularProgressIndicator()),
              Text(
                _fullname ?? "...",
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
              Text(
                _username ?? "...",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('ข้อมูลผู้ใช้'),
          trailing: const Icon(Icons.navigate_next),
          // visualDensity: VisualDensity(vertical: -4),
          // dense: true,
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text('เปลี่ยนรหัสผ่าน'),
          trailing: const Icon(Icons.navigate_next),
          // visualDensity: VisualDensity(vertical: -4),
          // dense: true,
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('เปลี่ยนภาษา'),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.email),
          title: const Text('ติดต่อทีมงาน'),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('ตั้งค่าใช้งาน'),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('ออกจากระบบ'),
          trailing: const Icon(Icons.navigate_next),
          onTap: () async {
            sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.clear();
            Navigator.pushReplacementNamed(context, '/login');
          },
        )
      ],
    );
  }
}
