// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutterscale/models/ProductModel.dart';
import 'package:flutterscale/screens/editproduct/editproduct_screen.dart';
import 'package:flutterscale/services/rest_api.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: FutureBuilder(
              future: CallAPI().getProducts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  // ถ้าโหลดข้อมูลไม่ได้ หรือมีข้อผิดพลาด
                  return const Center(
                    child: Text('มีข้อผิดพลาดในการโหลดข้อมูล'),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  // ถ้าโหลดข้อมูลสำเร็จ
                  List<ProductModel> products = snapshot.data;
                  return _listViewProduct(products);
                } else {
                  return const Center(
                    // ระหว่างที่กำหลังโหลดข้อมูล สามารถใส่ loading...
                    child: CircularProgressIndicator(),
                  );
                }
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/addproduct');
        },
        child: Icon(Icons.add, color: Colors.white, size: 30,),
        backgroundColor: Colors.red,
        splashColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // --------------------------------------------------------
  // สร้าง ListView สำหรับแสดงรายการสินค้า
  // --------------------------------------------------------
  Widget _listViewProduct(List<ProductModel> products) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: products.length,
        itemBuilder: (context, index) {
          // Load Model
          ProductModel product = products[index];
          return Card(
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: FadeInImage(
                                image: NetworkImage(product.productImage),
                                placeholder: AssetImage('assets/images/noimgpic.jpeg'),
                                imageErrorBuilder: (context, error, stackTrace) {
                                  return Image.asset('assets/images/noimgpic.jpeg');
                                },
                                fit: BoxFit.cover,
                            )
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, bottom: 5.0, left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.productName,
                                style: TextStyle(fontSize: 24),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                product.productBarcode,
                                style: TextStyle(fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                product.productPrice,
                                style: TextStyle(fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context, 
                              '/editproduct',
                              arguments: ScreenArguments(
                                product.id.toString(),
                                product.productName.toString(), 
                                product.productDetail.toString(), 
                                product.productBarcode, 
                                product.productPrice, 
                                product.productQty, 
                                product.productImage
                              )
                            ).then((value) => setState(() {
                              CallAPI().getProducts();
                            }));
                          },
                          child: Text('แก้ไข'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.yellow[900],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            return showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text('ยืนยันการลบข้อมูล'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text('รายการนี้จะถูกลบออกอย่างถาวร'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('ไม่ลบ'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('ยืนยัน'),
                                      onPressed: () async {
                                        var response = await CallAPI().deleteProduct(product.id.toString());
                                        if (response == true) {
                                          //Navigator.pushNamed(context, '/stockscreen');
                                          Navigator.pop(context, true);
                                          setState(() {
                                            CallAPI().getProducts();
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                );
                              }
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red[700],
                          ),
                          child: Text(
                            'ลบ',
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
