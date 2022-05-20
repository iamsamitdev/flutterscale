import 'package:flutter/material.dart';
import 'package:flutterscale/models/NewsModel.dart';
import 'package:flutterscale/utils/constants.dart' as Constant;
import 'package:flutterscale/services/rest_api.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          const SizedBox(
            height: 200,
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
                    }else if (snapshot.connectionState == ConnectionState.done) {
                      // ถ้าโหลดข้อมูลสำเร็จ
                      List<NewsModel> news = snapshot.data;
                      return _listViewAllNews(news);
                    } else {
                      return const Center(
                        // ระหว่างที่กำหลังโหลดข้อมูล สามารถใส่ loading...
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
            )
          ),
        ],
      ),
    );
  }

  // สร้าง ListView สำหรับการแสดงข่าวทั้งหมด
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
              print(index);
            },
          );
        });
  }
}
