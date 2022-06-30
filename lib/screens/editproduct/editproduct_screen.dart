// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutterscale/models/ProductModel.dart';
import 'package:flutterscale/services/rest_api.dart';

class EditProductScreen extends StatefulWidget {
  EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  final formKey = GlobalKey<FormState>();
  String? productName,
      productDetail,
      productBarcode,
      productPrice,
      productQty,
      productImage;

  Widget productNameText() {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return TextFormField(
      initialValue: args.productName,
      keyboardType: TextInputType.text,
      autofocus: false,
      style: TextStyle(fontSize: 16, color: Colors.black),
      decoration: InputDecoration(
          // icon: Icon(Icons.email),
          // hintText: 'you@email.com',
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
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return TextFormField(
      initialValue: args.productDetail,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      autofocus: false,
      style: TextStyle(fontSize: 16, color: Colors.black),
      decoration: InputDecoration(
          // icon: Icon(Icons.email),
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
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return TextFormField(
      initialValue: args.productBarcode,
      keyboardType: TextInputType.text,
      autofocus: false,
      style: TextStyle(fontSize: 16, color: Colors.black),
      decoration: InputDecoration(
          // icon: Icon(Icons.email),
          // hintText: 'you@email.com',
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
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return TextFormField(
      initialValue: args.productQty,
      keyboardType: TextInputType.number,
      autofocus: false,
      style: TextStyle(fontSize: 16, color: Colors.black),
      decoration: InputDecoration(
          // icon: Icon(Icons.email),
          // hintText: 'you@email.com',
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
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return TextFormField(
      initialValue: args.productPrice,
      keyboardType: TextInputType.number,
      autofocus: false,
      style: TextStyle(fontSize: 16, color: Colors.black),
      decoration: InputDecoration(
          // icon: Icon(Icons.email),
          // hintText: 'you@email.com',
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
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return TextFormField(
      initialValue: args.productImage,
      keyboardType: TextInputType.text,
      autofocus: false,
      style: TextStyle(fontSize: 16, color: Colors.black),
      decoration: InputDecoration(
          // icon: Icon(Icons.email),
          // hintText: 'you@email.com',
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

    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.productName),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 5, left: 20, right: 20),
                child: productNameText(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: productDetailText(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: productBarcodeText(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: productPriceText(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: productQtyText(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: productImageText(),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        // print('validation pass');
                        // print('productname = $productName, productdetail=$productDetail');

                        ProductModel productdata = new ProductModel(
                            id: args.id,
                            productName: productName.toString(),
                            productDetail: productDetail.toString(),
                            productBarcode: productBarcode.toString(),
                            productImage: productImage.toString(),
                            productPrice: productPrice.toString(),
                            productQty: productQty.toString()
                        );

                        // print(productdata);
                        var response = await CallAPI().updateProduct(productdata);
                        // print(response);
                        if (response == true) {
                          // print(response);
                          Navigator.pop(context, true);
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'อัพเดทข้อมูล',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}


class ScreenArguments {
  final String id,
      productName,
      productDetail,
      productBarcode,
      productPrice,
      productImage,
      productQty;

  ScreenArguments(
      this.id,
      this.productName,
      this.productDetail,
      this.productBarcode,
      this.productPrice,
      this.productQty,
      this.productImage);
}