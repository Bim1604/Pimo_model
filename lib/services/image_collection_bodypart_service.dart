import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:pimo/constants/Images.dart';
import 'package:pimo/models/collection_bodypart.dart';
import 'package:http/http.dart' as http;
import 'package:pimo/models/image_collection.dart';

class ImageCollectionBodyPartService {
  List<ListCollectionBodyPart> parseImageInCollectionList(
      String responseBody, int index) {
    int count = 0;
    var list = jsonDecode(responseBody);
    List<ListCollectionBodyPart> imageList = new List<ListCollectionBodyPart>();
    list['listCollectionProject'][index]['imageList']
        .map((e) => count++)
        .toList();
    for (int i = 0; i < count; i++) {
      imageList.add(ListCollectionBodyPart.fromJson(
          list['listCollectionProject'][i]['imageList']));
    }
    return imageList;
  }

  Future<List<ListCollectionBodyPart>> getImageInCollectionList(
      int index) async {
    final response = await http.get(Uri.parse(url + "api/v1/models/28"));
    if (response.statusCode == 200) {
      var list = parseImageInCollectionList(response.body, index);
      return list;
    } else {
      throw Exception('Unable to fetch image Collection from the REST API');
    }
  }

  List<ImageCollectionTest> parseImageCollectionList(String responseBody) {
    int count = 0;
    var list = jsonDecode(responseBody);
    List<ImageCollectionTest> imageList = new List<ImageCollectionTest>();
    list['product'].map((e) => count++).toList();
    for (int i = 0; i < count; i++) {
      imageList.add(ImageCollectionTest.fromJson(list['product'][i]));
    }
    return imageList;
  }

  Future<List<ImageCollectionTest>> fetchImageCollection() async {
    final response = await http.get(Uri.parse(url + "api/v1/projects/model/1"));
    if (response.statusCode == 200) {
      var list = parseImageCollectionList(response.body);
      return list;
    } else {
      throw Exception("Request API error");
    }
  }

  Future<void> createCollection(String collectionName) async {
    // var token = (await FlutterSession().get("token")).toString();
    // Map<String, String> heads = Map<String, String>();
    // heads['Content-Type'] = 'application/json';
    // heads['Accept'] = 'application/json';
    // // heads['Authorization'] = 'Bearer $token';
    Map<String, dynamic> body = Map<String, dynamic>();
    body['name'] = collectionName;
    var mess = jsonEncode(body);
    // String modelId = (await FlutterSession().get('modelId')).toString();
    final response = await http.post(
      Uri.parse(url + "api/v1/products/1"),
      body: mess,
    );
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Create success');
    } else {
      Fluttertoast.showToast(msg: 'Create fail');
      return null;
    }
  }

  Future<void> deleteCollection(int collectionId) async {
    // var token = (await FlutterSession().get("token")).toString();
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    // heads['Authorization'] = 'Bearer $token';
    // final response = await http
    //     .delete(Uri.parse(baseUrl + "api/v1/collection-images/$collectionId"),
    //     headers: heads);
    final response = await http
        .delete(Uri.parse(url + "api/v1/collection-images/1"), headers: heads);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Delete success');
    } else {
      Fluttertoast.showToast(msg: 'Delete fail');
      return null;
    }
  }

  // Future<bool> convertToGif(int collectionId) async {
  //   var images = await ImageService().getImageList(collectionId);
  //
  //   List<Map<String, dynamic>> fileValues = List<Map<String, dynamic>>();
  //   for (int i = 0; i < images.length; i++) {
  //     Map<String, dynamic> url = Map<String, dynamic>();
  //     url['Url'] = images.elementAt(i).fileName;
  //     fileValues.add(url);
  //   }
  //   // Map<String, dynamic> urlsEx = Map<String, dynamic>();
  //   // urlsEx['Name'] = 'F:\\my_file.jpg';
  //   // urlsEx['Data'] = 'Base64';
  //   // fileValues.add(urlsEx);
  //
  //   List<Map<String, dynamic>> parameters = List<Map<String, dynamic>>();
  //   Map<String, dynamic> files = Map<String, dynamic>();
  //   files['Name'] = 'Files';
  //   files['FileValues'] = fileValues;
  //   parameters.add(files);
  //
  //   Map<String, dynamic> storeFiles = Map<String, dynamic>();
  //   storeFiles['Name'] = 'StoreFile';
  //   storeFiles['Value'] = true;
  //   parameters.add(storeFiles);
  //
  //   Map<String, dynamic> parameter = Map<String, dynamic>();
  //   parameter['Parameters'] = parameters;
  //
  //   final message = jsonEncode(parameter);
  //
  //   final response = await http.post(
  //       Uri.parse('https://v2.convertapi.com/convert/jpg/to/gif?Secret=afGAodLwkQyIPtOQ'),
  //       body: message,
  //       headers: {"Content-Type": "application/json"});
  //   if (response.statusCode == 200) {
  //     var json = jsonDecode(response.body);
  //     var gif = ImageCollectionGif.fromJson(json);
  //     await ImageService().saveGif(gif, collectionId);
  //     return true;
  //   }
  //   else {
  //     Fluttertoast.showToast(msg: 'Picture must same size');
  //     return false;
  //   }
  // }
}
