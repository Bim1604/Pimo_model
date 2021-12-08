import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pimo/constants/Images.dart';
import 'package:pimo/models/casting.dart';
import 'package:http/http.dart' as http;
import 'casting_service.dart';

class ApplyCastingService {
  Future<List<Casting>> createApplyCasting(int castingId) async {
    Map<String, dynamic> params = Map<String, dynamic>();
    params['castingId'] = castingId;

    final message = jsonEncode(params);
    final response = await http.post(Uri.parse(url + 'api/v1/apply-castings'),
        body: message);
    // headers: heads);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Apply success');
      return await CastingService().modelApplyCasting();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<bool> isApply(int castingId) async {
    final response = await http.get(Uri.parse(
        url + 'api/v1/apply-castings/check?modelId=1&castingId=$castingId'));
    if (response.statusCode == 200) {
      final res = response.body;
      if (res == 'true') {
        return true;
      }
      return false;
    } else {
      throw Exception('Failed to load');
    }
  }
}
