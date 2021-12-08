import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pimo/constants/Images.dart';
import 'package:pimo/models/body.dart';

class BodyPartService {
  List<BodyPart> parseBodyPartList(String responseBody) {
    int count = 0;
    var list = jsonDecode(responseBody);
    List<BodyPart> collectionListProject = new List<BodyPart>();
    list['listBodyPart'].map((e) => count++).toList();
    for (int i = 0; i < count; i++) {
      collectionListProject.add(BodyPart.fromJson(list['listBodyPart'][i]));
    }
    return collectionListProject;
  }

  Future<List<BodyPart>> getBodyPartList(int modelId) async {
    final response = await http.get(Uri.parse(url + "api/v1/models/$modelId"));
    if (response.statusCode == 200) {
      var list = parseBodyPartList(response.body);
      return list;
    } else {
      throw Exception("Cannot fetch body ");
    }
  }

  Future<List<BodyPart>> getBodyStylesList() async {
    final response = await http.get(Uri.parse(url + "api/v1/models/1"));
    if (response.statusCode == 200) {
      var list = parseBodyPartList(response.body);
      return list;
    } else {
      throw Exception("Cannot fetch body ");
    }
  }
}
