import 'package:flutter/material.dart';
import 'package:flutterscale/screens/addproduct/addproduct_screen.dart';
import 'package:flutterscale/screens/dashboard/dashboard_screen.dart';
import 'package:flutterscale/screens/editproduct/editproduct_screen.dart';
import 'package:flutterscale/screens/login/login_screen.dart';
import 'package:flutterscale/screens/newsdetail/newsdetail_screen.dart';
import 'package:flutterscale/screens/register/register_screen.dart';
import 'package:flutterscale/screens/welcome/welcome_screen.dart';

// สร้างตัวแปรแบบ Map
Map<String,WidgetBuilder> routes = {
  "/welcome": (BuildContext context) => const WelcomeScreen(),
  "/login": (BuildContext context) => const LoginScreen(),
  "/register": (BuildContext context) => const RegisterScreen(),
  "/dashboard": (BuildContext context) => const DashboardScreen(),
  "/newdetail": (BuildContext context) => NewsDetailScreen(),
  "/addproduct": (BuildContext context) => AddProductScreen(),
  "/editproduct": (BuildContext context) => EditProductScreen(),
};