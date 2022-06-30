// ignore_for_file: prefer_if_null_operators, unnecessary_null_comparison, file_names

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.id,
        required this.username,
        required this.password,
        required this.fullname,
        required this.imgProfile,
        required this.status,
    });

    String id;
    String username;
    String password;
    String fullname;
    String imgProfile;
    String status;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        password: json["password"] == null ? null : json["password"],
        fullname: json["fullname"] == null ? null : json["fullname"],
        imgProfile: json["img_profile"] == null ? null : json["img_profile"],
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "password": password == null ? null : password,
        "fullname": fullname == null ? null : fullname,
        "img_profile": imgProfile == null ? null : imgProfile,
        "status": status == null ? null : status,
    };
}
