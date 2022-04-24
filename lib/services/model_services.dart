import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:pimo/constants/Images.dart';
import 'package:pimo/models/model.dart';
import 'package:http/http.dart' as http;
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';

class ModelServices {
  updateModelDetail(Map<String, dynamic> params) async {
    final message = jsonEncode(params);

    var jwt = (await FlutterSession().get("jwt")).toString();
    final response = await http
        .put(Uri.parse(url + 'api/v1/models'), body: message, headers: {
      "Content-Type": "multipart/form-data",
      "Accept": "application/json",
      "Authorization": 'Bearer $jwt',
    });
    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Cập nhật thành công');
      } else {
        print(response.headers);
      }
    } on Exception catch (exception) {
      print("Exception: " + exception.toString());
    } catch (error) {
      print("ERROR: " + error.toString());
    }
    ;
  }

  Future<Model> getModelDetail(int modelId) async {
    final response = await http.get(Uri.parse(url + 'api/v1/models/$modelId'));
    if (response.statusCode == 200) {
      var model = Model.fromJson(jsonDecode(response.body));
      return model;
    } else {
      throw Exception('Failed to load Model !');
    }
  }
}
