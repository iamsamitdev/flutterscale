// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterscale/models/ProductModel.dart';
import 'package:flutterscale/services/rest_api.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  final formKey = GlobalKey<FormState>();

  String? productName, 
          productDetail,
          productBarcode,
          productPrice,
          productQty,
          productImage;

  Widget productNameText() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      style: TextStyle(fontSize: 20, color: Colors.black),
      decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          labelText: 'ชื่อสินค้า',
          labelStyle: TextStyle(color: Colors.teal, fontSize: 20),
          errorStyle: TextStyle(fontSize: 16.0)),
      validator: (value) {
        if (value!.isEmpty) {
          return "* จำเป็น";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        productName = value;
      },
    );
  }

  Widget productDetailText() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      autofocus: false,
      style: TextStyle(fontSize: 20, color: Colors.black),
      decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          labelText: 'รายละเอียด',
          labelStyle: TextStyle(color: Colors.teal, fontSize: 20),
          errorStyle: TextStyle(fontSize: 16.0)),
      validator: (value) {
        if (value!.isEmpty) {
          return "* จำเป็น";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        productDetail = value;
      },
    );
  }

  Widget productBarcodeText() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      style: TextStyle(fontSize: 20, color: Colors.black),
      decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          labelText: 'บาร์โค้ด',
          labelStyle: TextStyle(color: Colors.teal, fontSize: 20),
          errorStyle: TextStyle(fontSize: 16.0)),
      validator: (value) {
        if (value!.isEmpty) {
          return "* จำเป็น";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        productBarcode = value;
      },
    );
  }

  Widget productQtyText() {
    return TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      style: TextStyle(fontSize: 20, color: Colors.black),
      decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          labelText: 'จำนวน',
          labelStyle: TextStyle(color: Colors.teal, fontSize: 20),
          errorStyle: TextStyle(fontSize: 16.0)),
      validator: (value) {
        if (value!.isEmpty) {
          return "* จำเป็น";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        productQty = value;
      },
    );
  }

  Widget productPriceText() {
    return TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      style: TextStyle(fontSize: 20, color: Colors.black),
      decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          labelText: 'ราคา',
          labelStyle: TextStyle(color: Colors.teal, fontSize: 20),
          errorStyle: TextStyle(fontSize: 16.0)),
      validator: (value) {
        if (value!.isEmpty) {
          return "* จำเป็น";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        productPrice = value;
      },
    );
  }

  Widget productImageText() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      style: TextStyle(fontSize: 20, color: Colors.black),
      decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          labelText: 'รูปภาพสินค้า',
          labelStyle: TextStyle(color: Colors.teal, fontSize: 20),
          errorStyle: TextStyle(fontSize: 16.0)),
      validator: (value) {
        if (value!.isEmpty) {
          return "* จำเป็น";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        productImage = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่มสินค้าใหม่'),
      ),
      body: GestureDetector(
        onTap: () { FocusScope.of(context).unfocus(); },
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: productNameText(),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: productDetailText(),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: productBarcodeText(),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: productPriceText(),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: productQtyText(),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: productImageText(),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 5, left: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        // ignore: unnecessary_new
                        ProductModel productdata = new ProductModel(
                            productName: productName.toString(),
                            productDetail: productDetail.toString(),
                            productBarcode: productBarcode.toString(),
                            productImage: productImage.toString(),
                            productPrice: productPrice.toString(),
                            productQty: productQty.toString()
                        );

                        inspect(productdata);
                        var response = await CallAPI().createProduct(productdata);

                        if(response == true){
                          Navigator.pop(context,true);
                        }
                        
                        // print(response);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'บันทึกข้อมูล',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ))
            ],
          )
        ),
      ),
    );
  }
}