import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pimo/constants/Images.dart';
import 'package:pimo/models/availible.dart';

class AvailibleService {
  List<Availible> parseAvalibleList(String responseBody) {
    int count = 0;
    var list = jsonDecode(responseBody);
    List<Availible> collectionListProject = new List<Availible>();

    list['availabilityList'].map((e) => count++).toList();

    for (int i = 0; i < count; i++) {
      collectionListProject
          .add(Availible.fromJson(list['availabilityList'][i]));
    }
    return collectionListProject;
  }

  Future<List<Availible>> getAvaibleList(int modelId) async {
    final response = await http.get(Uri.parse(url + "api/v1/models/$modelId"));
    if (response.statusCode == 200) {
      var list = parseAvalibleList(response.body);
      return list;
    } else {
      throw Exception("Cannot fetch body ");
    }
  }
}
