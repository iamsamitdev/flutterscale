// ignore_for_file: unnecessary_null_comparison, library_prefixes

import 'dart:convert';

import 'package:flutterscale/models/NewsDetailModel.dart';
import 'package:flutterscale/models/NewsModel.dart';
import 'package:flutterscale/models/ProductModel.dart';
import 'package:flutterscale/models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutterscale/utils/constants.dart' as Constant;

class CallAPI {

  // กำหนด header ของ api
  _setHeaders() => {
    'Content-Type':'application/json',
    'Accept':'application/json'
  };

  // Login API Method
  loginAPI(data) async {
    return await http.post(
      Uri.parse(Constant.baseAPIURL+'login'),
      body: jsonEncode(data),
      headers: _setHeaders()
    );
  }

  // Read All News Method
  Future<List<NewsModel>?> getAllNews() async {
    final response = await http.get(
      Uri.parse(Constant.baseAPIURL+'news'),
      headers: _setHeaders()
    );
    if(response.body != null){
      return newsModelFromJson(response.body);
    }else{
      return null;
    }
  }

  // อ่านข่าวล่าสุด 5 รายการ
  Future<List<NewsModel>?> getLastNews() async {
    final response = await http.get(
      Uri.parse(Constant.baseAPIURL+'lastnews'),
      headers: _setHeaders()
    );
    if(response.body != null){
      return newsModelFromJson(response.body);
    }else{
      return null;
    }
  }

  // อ่านรายละเอียดข่าวตาม id 
  Future<NewsDetailModel?> getNewsByID(id) async {
    final response = await http.get(
      Uri.parse(Constant.baseAPIURL+'news/'+id),
      headers: _setHeaders()
    );
    if(response.body != null){
      return newsDetailModelFromJson(response.body);
    }else{
      return null;
    }
  }

  // แสดงโปรไฟล์ของ user
  Future<UserModel?> getProfile(id) async {
    final response = await http.get(
      Uri.parse(Constant.baseAPIURL+'users/'+id),
      headers: _setHeaders()
    );
    if(response.body != null){
      return userModelFromJson(response.body);
    }else{
      return null;
    }
  }

  // ------------------------------------------------
  // ส่วนของการ CRUD Product
  // ------------------------------------------------
  // Get All Products
  Future<List<ProductModel>?> getProducts() async {
    final response = await http.get(
      Uri.parse(Constant.baseAPIURL+'products'),
      headers: _setHeaders()
    );

    if(response.statusCode == 200){
      return productModelFromJson(response.body);
    }else{
      return null;
    }
  }

  // Add New Product
  Future<bool> createProduct(ProductModel data) async {
    final response = await http.post(
      Uri.parse(Constant.baseAPIURL+'products'),
      headers: _setHeaders(),
      body: productModelToJson(data)
    );
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  // Update Products
  Future<bool> updateProduct(ProductModel data) async {
    final response = await http.put(
      Uri.parse(Constant.baseAPIURL + "products/${data.id}"),
      headers: _setHeaders(),
      body: productModelToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Delete Products
  Future<bool> deleteProduct(String id) async {
    final response = await http.delete(
       Uri.parse(Constant.baseAPIURL + "products/$id"),
      headers: _setHeaders()
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}