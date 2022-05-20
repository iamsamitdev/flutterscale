import 'dart:convert';
import 'dart:ffi';

import 'package:flutterscale/models/NewsModel.dart';
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

}