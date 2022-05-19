import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(),
      drawer: SizedBox(
        width: 200,
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
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/samit.jpeg'),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Samit Koyom', 
                              style: TextStyle(color: Colors.white)
                            ),
                            Text(
                              'samit@email.com', 
                              style: TextStyle(color: Colors.white)
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
              ListTile(
                leading: const Icon(Icons.info, size: 18, color: Colors.white,),
                title: const Text('เกี่ยวกับเรา'),
                minLeadingWidth: 0,
                horizontalTitleGap: 5,
                visualDensity: const VisualDensity(vertical: -3),
                dense: true,
                onTap: (){},
              ),
              ListTile(
                leading: const Icon(Icons.book, size: 18, color: Colors.white,),
                title: const Text('ข้อมูลการใช้งาน'),
                minLeadingWidth: 0,
                horizontalTitleGap: 5,
                visualDensity: const VisualDensity(vertical: -3),
                dense: true,
                onTap: (){},
              ),
              ListTile(
                leading: const Icon(Icons.email, size: 18, color: Colors.white,),
                title: const Text('ติดต่อทีมงาน'),
                minLeadingWidth: 0,
                horizontalTitleGap: 5,
                visualDensity: const VisualDensity(vertical: -3),
                onTap: (){},
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app, size: 18, color: Colors.white,),
                title: const Text('ออกจากระบบ'),
                minLeadingWidth: 0,
                horizontalTitleGap: 5,
                visualDensity: const VisualDensity(vertical: -3),
                onTap: () async {
                  // สร้าง Object Sharedprefference
                  SharedPreferences sharedPreferences = 
                  await SharedPreferences.getInstance();

                  // เคลียร์ค่า Sharedprefference
                  sharedPreferences.clear();

                  // ส่งไปหน้า login
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}