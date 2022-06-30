// ignore_for_file: avoid_print, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutterscale/models/NewsModel.dart';
import 'package:flutterscale/services/rest_api.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'ข่าวประกาศล่าสุด',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
                height: 210.0,
                child: FutureBuilder(
                    future: CallAPI().getLastNews(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        // ถ้าโหลดข้อมูลไม่ได้ หรือมีข้อผิดพลาด
                        return const Center(
                          child: Text('มีข้อผิดพลาดในการโหลดข้อมูล'),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        // ถ้าโหลดข้อมูลสำเร็จ
                        List<NewsModel> news = snapshot.data;
                        return _listViewLastNews(news);
                      } else {
                        return const Center(
                          // ระหว่างที่กำหลังโหลดข้อมูล สามารถใส่ loading...
                          child: CircularProgressIndicator(),
                        );
                      }
                    })
                  ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'ข่าวประกาศทั้งหมด',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: FutureBuilder(
                    future: CallAPI().getAllNews(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        // ถ้าโหลดข้อมูลไม่ได้ หรือมีข้อผิดพลาด
                        return const Center(
                          child: Text('มีข้อผิดพลาดในการโหลดข้อมูล'),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        // ถ้าโหลดข้อมูลสำเร็จ
                        List<NewsModel> news = snapshot.data;
                        return _listViewAllNews(news);
                      } else {
                        return const Center(
                          // ระหว่างที่กำหลังโหลดข้อมูล สามารถใส่ loading...
                          child: CircularProgressIndicator(),
                        );
                      }
                    })),
          ],
        ),
      ),
    );
  }

  //----------------------------------
  // สร้าง ListView สำหรับการแสดงข่าวทั้งหมด
  //----------------------------------
  Widget _listViewAllNews(List<NewsModel> news) {
    return ListView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: news.length,
        itemBuilder: (context, index) {
          // Load Model
          NewsModel newsModel = news[index];

          return ListTile(
            leading: const Icon(Icons.pages),
            title: Text(newsModel.topic, overflow: TextOverflow.ellipsis),
            subtitle: Text(newsModel.detail, overflow: TextOverflow.ellipsis),
            onTap: () {
              Navigator.pushNamed(
                  context, 
                  '/newdetail', 
                  arguments: {'id': newsModel.id}
              );
            },
          );
        });
  }

  //----------------------------------
  // สร้าง ListView สำหรับการแสดงข่าวล่าสุด
  //----------------------------------
  Widget _listViewLastNews(List<NewsModel> news) {
    return ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal, // Listview แนวนอน
        itemCount: news.length,
        itemBuilder: (context, index) {
          // Load Model
          NewsModel newsModel = news[index];
          // ออกแบบส่วนหน้าตาของการแสดงผล listview
          return Container(
            width: MediaQuery.of(context).size.width * 0.60,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  '/newdetail', 
                  arguments: {'id': newsModel.id}
                );
              },
              child: Card(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 125.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(newsModel.imageurl),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              newsModel.topic,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              newsModel.detail,
                              style: TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
