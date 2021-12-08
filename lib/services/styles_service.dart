import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pimo/constants/Images.dart';
import 'package:pimo/models/styles.dart';

class StylesService {
  List<Styles> parseStylesList(String responseBody) {
    int count = 0;
    var list = jsonDecode(responseBody);
    List<Styles> stylesListProject = new List<Styles>();
    list['styleList'].map((e) => count++).toList();
    for (int i = 0; i < count; i++) {
      stylesListProject.add(Styles.fromJson(list['styleList'][i]));
    }
    return stylesListProject;
  }

  Future<List<Styles>> getStylesList(int modelId) async {
    final response = await http.get(Uri.parse(url + "api/v1/models/$modelId"));
    if (response.statusCode == 200) {
      var list = parseStylesList(response.body);
      return list;
    } else {
      throw Exception("Cannot fetch body ");
    }
  }
}
