import 'package:flutter/material.dart';
import 'package:flutterscale/screens/bottomnavmenu/home_screen.dart';
import 'package:flutterscale/screens/bottomnavmenu/notification_screen.dart';
import 'package:flutterscale/screens/bottomnavmenu/profile_screen.dart';
import 'package:flutterscale/screens/bottomnavmenu/report_screen.dart';
import 'package:flutterscale/screens/bottomnavmenu/setting_screen.dart';
import 'package:flutterscale/screens/dashboard/menu_list.dart';
import 'package:flutterscale/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
   const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // สร้าง Sharedprefference Object
  late SharedPreferences sharedPreferences;

  // ตัวแปรเก็บ username , fullname, imgprofile
  String? username;
  String? fullname; 
  String? imgprofile;

  // สร้างตัวแปรไว้เก็บ list รายการของ Bottomnavigation menu
  int _currentIndex = 0;
  // สร้างตัวแปรไว้เก็บ title
  String _title = 'หน้าหลัก';

  // สร้าง list เก็บ Screen
  final List<Widget> _children = [
    const HomeScreen(),
    const ReportScreen(),
    const NotificationScreen(),
    const SettingScreen(),
    const ProfileScreen()
  ];

  void getUserProfile() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPreferences.getString('userName')!;
      fullname = sharedPreferences.getString('fullName')!;
      imgprofile = sharedPreferences.getString('imgProfile')!;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  // สร้าง method สำหรับการเปลี่ยน tab
  void onTabChange(int index){
    setState(() {
      _currentIndex = index;
      switch(index) {
        case 0: _title = home_menu; break;
        case 1: _title = report_menu; break;
        case 2: _title = notification_menu; break;
        case 3: _title = setting_menu; break;
        case 4: _title = profile_menu; break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabChange,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: home_menu
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_outlined),
            label: report_menu
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: notification_menu
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: setting_menu
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: product_menu
          )
        ]
      ),
      drawer: SizedBox(
        width: 300,
        child: Drawer(
          backgroundColor: Colors.teal,
          child: ListView(
            children: [
              SizedBox(
                height: 70.0,
                child: DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.blue),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      children: [
                        imgprofile != null ? CircleAvatar(
                          backgroundImage: NetworkImage('https://www.itgenius.co.th/sandbox_api/mrta_flutter_api/public/images/profile/'+imgprofile!),
                        ): const CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fullname ?? '...', 
                              style: const TextStyle(color: Colors.white, fontSize: 20)
                            ),
                            Text(
                              username ?? '...', 
                              style: const TextStyle(color: Colors.white)
                            )
                          ],
                        ),
                      )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              MenuList(
                micon: Icons.info, 
                mname: about_menu, 
                onTap: (){ print('Tapped About'); }
              ),
              MenuList(
                micon: Icons.book, 
                mname: info_menu, 
                onTap: (){ print('Tapped Infomation'); }
              ),
              MenuList(
                micon: Icons.email, 
                mname: contact_menu, 
                onTap: (){ print('Tapped Contact'); }
              ),
              MenuList(
                micon: Icons.exit_to_app, 
                mname: logout_menu, 
                onTap: () async {
                  // สร้าง Object Sharedprefference
                  SharedPreferences sharedPreferences = 
                  await SharedPreferences.getInstance();

                  // เคลียร์ค่า Sharedprefference
                  sharedPreferences.clear();

                  // ส่งไปหน้า login
                  Navigator.of(context).pushReplacementNamed('/login');
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}