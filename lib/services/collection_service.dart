import 'dart:convert';

import 'package:pimo/constants/Images.dart';
import 'package:http/http.dart' as http;
import 'package:pimo/models/collection_project.dart';
import 'package:pimo/models/collection_bodypart.dart';

class CollectionService {
  List<ListCollectionProject> parseListCollectionProject(String responseBody) {
    int count = 0;
    var list = jsonDecode(responseBody);
    List<ListCollectionProject> collectionListProject =
        new List<ListCollectionProject>();
    list['listCollectionProject'].map((e) => count++).toList();
    for (int i = 0; i < count; i++) {
      collectionListProject.add(
          ListCollectionProject.fromJson(list['listCollectionProject'][i]));
    }
    return collectionListProject;
  }

  Future<List<ListCollectionProject>> fetchListCollectionProject(String modelId) async {
    final response = await http.get(Uri.parse(url + "api/v1/models/$modelId"));
    if (response.statusCode == 200) {
      var list = parseListCollectionProject(response.body);
      return list;
    } else {
      throw Exception("Request API error");
    }
  }

  Future<List<ListCollectionBodyPart>> fetchListCollectionBodyPart(String modelId) async {
    final response = await http.get(Uri.parse(url + "api/v1/models/$modelId"));
    if (response.statusCode == 200) {
      var list = jsonDecode(response.body);
      int count = 0;
      List<ListCollectionBodyPart> collectionListBodyPart =
          List<ListCollectionBodyPart>();
      list['listCollectionBody'].map((e) => count++).toList();
      for (int i = 0; i < count; i++) {
        collectionListBodyPart.add(
            ListCollectionBodyPart.fromJson(list['listCollectionBody'][i]));
      }
      return collectionListBodyPart;
    } else {
      throw Exception("Request API error");
    }
  }
}
