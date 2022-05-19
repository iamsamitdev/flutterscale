import 'package:flutter/material.dart';
import 'package:flutterscale/routers.dart';
import 'package:flutterscale/themes/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

var userStep;
var initURL;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  userStep = sharedPreferences.getInt('userStep');

  if(userStep == 1){
    initURL = '/home';
  }else{
    initURL = '/welcome';
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme(),
      initialRoute: initURL,
      routes: routes,
    );
  }
}