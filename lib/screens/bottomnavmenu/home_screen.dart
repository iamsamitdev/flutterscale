import 'package:flutter/material.dart';
import 'package:flutterscale/screens/tabbarmenu/news_screen.dart';
import 'package:flutterscale/screens/tabbarmenu/products_screen.dart';
import 'package:flutterscale/screens/tabbarmenu/stores_screen.dart';
import 'package:flutterscale/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            bottom: const TabBar(
              labelStyle: TextStyle(fontSize: 18, fontFamily: 'NotoSansThai'),
              labelColor: Colors.white,
              indicatorColor: Colors.amberAccent,
              tabs: [
                Tab(text: news_menu),
                Tab(text: product_menu),
                Tab(text: store_menu),
              ])
            ,
          ),
        ),
        body: const TabBarView(
          children: [
            NewsScreen(),
            ProductsScreen(),
            StoresScreen()
          ]
        ),
      )
    );
  }
}