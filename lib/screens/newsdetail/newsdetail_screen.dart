// ignore_for_file: prefer_const_constructors_in_immutables, unused_field, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutterscale/models/NewsDetailModel.dart';
import 'package:flutterscale/services/rest_api.dart';

class NewsDetailScreen extends StatefulWidget {
  NewsDetailScreen({Key? key}) : super(key: key);

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {

  // เรียกใช้งาน NewsDetailModel
  NewsDetailModel? _dataNews;

  // สร้างฟังก์ชันอ่านรายละเอียดข่าว
  readNewsDetail(id) async {
    // Call API
    try {
      var response = await CallAPI().getNewsByID(id);
      setState(() {
        _dataNews = response;
      });
    } catch (error){
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {

    // การรับค่า arguments
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    print(arguments['id']);

    // เรียกใช้งานฟังก์ชัน readNewsDetail(id)
    readNewsDetail(arguments['id'].toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(_dataNews?.topic ?? "..."),
      ),
      body: ListView(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_dataNews?.imageurl ?? "..."),
                fit: BoxFit.cover
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              _dataNews?.topic ?? "...",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              _dataNews?.detail ?? "...",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Published Date: ${_dataNews?.createdAt.toString() ?? "..."}',
              style: TextStyle(fontSize: 16.0),
            ),
          )
        ]
      ),
    );

  }
}