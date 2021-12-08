import 'dart:convert';

import 'package:pimo/constants/Images.dart';
import 'package:http/http.dart' as http;

class Model {
  final int id;
  final String name;
  final int gender;
  final String genderName;
  final String dateOfBirth;
  final String country;
  final String province;
  final String district;
  final String phone;
  final String mail;
  final String avatar;
  final String gifted;
  final String description;
  final bool status;
  final String linkFace;
  final String linkIns;
  final String linkTwitter;
  final String linkAvatar;
  final String imageAvatar;

  // final List<ModelStyle> modelStyle;

  Model(
      {this.id,
      this.name,
      this.gender,
      this.dateOfBirth,
      this.country,
      this.province,
      this.district,
      this.phone,
      this.genderName,
      this.mail,
      this.avatar,
      this.linkFace,
      this.linkIns,
      this.linkTwitter,
      this.gifted,
      this.status,
      this.linkAvatar,
      this.imageAvatar,
      this.description});

  //static method
  factory Model.fromJson(Map<String, dynamic> json) {
    // var list = json['modelStyle'] as List;
    // List<ModelStyle> styleList =
    //     list.map((i) => ModelStyle.fromJson(i)).toList();
    return Model(
      id: json["model"][0]["model"]["id"],
      name: json["model"][0]["model"]["name"],
      gender: json["model"][0]["model"]["genderId"],
      dateOfBirth: json["model"][0]["model"]["dateOfBirth"],
      country: json["model"][0]["model"]["country"],
      province: json["model"][0]["model"]["province"],
      district: json["model"][0]["model"]["district"],
      phone: json["model"][0]["model"]["phone"],
      mail: json["model"][0]["model"]["mail"],
      gifted: json["model"][0]["model"]["gifted"],
      avatar: json["model"][0]["model"]["avatar"],
      status: json["model"][0]["model"]["status"],
      description: json["model"][0]["model"]["description"],
      genderName: json["model"][0]["genderName"],
      linkFace: json["model"][0]["facebook"],
      linkTwitter: json["model"][0]["twitter"],
      linkIns: json["model"][0]["instagram"],
    );
  }

  // Future<Model> updateModelDetail(Map<String, dynamic> params) async {
  //   final message = jsonEncode(params);
  //   final response = await http.put(
  //       Uri.parse(
  //           url + 'api/v1/models/1/profile'),
  //       body: message,
  //      );
  //   if (response.statusCode == 200) {
  //     var responseBody = Model.fromJson(jsonDecode(response.body));
  //     return responseBody;
  //   } else {
  //     throw Exception('Failed to load');
  //   }
  // }
}
