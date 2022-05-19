import 'package:flutter/material.dart';
import 'package:flutterscale/screens/home/home_screen.dart';
import 'package:flutterscale/screens/login/login_screen.dart';
import 'package:flutterscale/screens/register/register_screen.dart';
import 'package:flutterscale/screens/welcome/welcome_screen.dart';

// สร้างตัวแปรแบบ Map
Map<String,WidgetBuilder> routes = {
  "/welcome": (BuildContext context) => const WelcomeScreen(),
  "/login": (BuildContext context) => const LoginScreen(),
  "/register": (BuildContext context) => const RegisterScreen(),
  "/home": (BuildContext context) => const HomeScreen(),
};