import 'dart:convert';
import 'package:pimo/constants/Images.dart';
import 'package:pimo/models/casting.dart';
import 'package:http/http.dart' as http;
import 'package:pimo/models/casting_applies.dart';
import 'package:pimo/models/casting_browse.dart';
import 'package:pimo/models/casting_info.dart';
import 'package:pimo/models/casting_result.dart';
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';
import 'package:pimo/viewmodels/casting_view_model.dart';

class CastingService {
  List<Casting> parseCastingList(String responseBody) {
    int count = 0;
    var list = jsonDecode(responseBody);
    List<Casting> castingInfoList = new List<Casting>();

    list['castings'].map((e) => count++).toList();
    return castingInfoList;
  }

  List<CastingInfo> parseCastingInfoList(String responseBody) {
    int count = 0;
    var list = jsonDecode(responseBody);
    List<CastingInfo> castingInfoList = new List<CastingInfo>();
    list['castings'].map((e) => count++).toList();
    for (int i = 0; i < count; i++) {
      castingInfoList.add(CastingInfo.fromJson(list['castings'][i]));
    }
    return castingInfoList;
  }

  Future<List<Casting>> getCastingList() async {
    final response = await http.get(Uri.parse(url + "api/v1/castings"));
    if (response.statusCode == 200) {
      var list = parseCastingList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Casting>> searchCastingList(
      String name, String min, String max) async {
    final response = await http.get(
        Uri.parse(url + "api/v1/castings/search?name=$name&min=$min&max=$max"));
    if (response.statusCode == 200) {
      var list = parseCastingList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Casting>> modelApplyCasting() async {
    final response = await http.get(Uri.parse(url + 'api/v1/castings/1/allpy'));
    if (response.statusCode == 200) {
      var list = parseCastingList(response.body);
      return list;
    } else {
      return null;
    }
  }

  Future<List<Casting>> getIncomingCasting() async {
    final response = await http.get(Uri.parse(url + 'api/v1/castings'));
    if (response.statusCode == 200) {
      var list = parseCastingList(response.body);
      return list;
    } else {
      return null;
      // throw Exception('Failed to load');
    }
  }

  Future<CastingViewModel> getCasting(String castingId) async {
    final response =
        await http.get(Uri.parse(url + 'api/v1/castings/$castingId'));
    if (response.statusCode == 200) {
      var casting = CastingViewModel(
          casting: Casting.fromJson(jsonDecode(response.body)));
      return casting;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Casting>> getCastingByIds(List<int> castingIds) async {
    Map<String, dynamic> params = Map<String, dynamic>();
    params['castingIds'] = castingIds;
    final message = jsonEncode(params);
    final response =
        await http.post(Uri.parse(url + 'api/v1/castings'), body: message);
    if (response.statusCode == 200) {
      var list = parseCastingList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<CastingInfo>> getCastingInfoDetail(int castingId) async {
    final response = await http
        .get(Uri.parse(url + "api/v1/castings/information/${castingId}"));
    if (response.statusCode == 200) {
      var list = parseCastingInfoList(response.body);
      return list;
    } else {
      throw Exception("Request API error");
    }
  }

  Future<List<CastingInfo>> getCastingInfoList() async {
    final response = await http.get(Uri.parse(url + "api/v1/castings"));
    if (response.statusCode == 200) {
      var list = parseCastingInfoList(response.body);
      return list;
    } else {
      throw Exception("Request API error");
    }
  }

  Future<List<CastingBrowses>> getCastingBrowseList() async {
    var jwt = (await FlutterSession().get("jwt")).toString();
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
      'Authorization': 'Bearer ' + jwt
    };
    final response =
        await http.get(Uri.parse(url + "api/v1/browses"), headers: headers);
    if (response.statusCode == 200) {
      var list = parseCastingBrowseList(response.body);
      return list;
    } else {
      throw Exception("ERROR at getCastingBrowseList");
    }
  }

  List<CastingBrowses> parseCastingBrowseList(String responseBody) {
    int count = 0;
    var list = jsonDecode(responseBody);
    List<CastingBrowses> castingBrowse = new List<CastingBrowses>();
    list['castingBrowses'].map((e) => count++).toList();
    for (int i = 0; i < count; i++) {
      castingBrowse.add(CastingBrowses.fromJson(list['castingBrowses'][i]));
    }
    return castingBrowse;
  }

  Future<List<ApplyList>> getCastingAppliesList() async {
    var jwt = (await FlutterSession().get("jwt")).toString();
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
      'Authorization': 'Bearer ' + jwt
    };

    final response =
        await http.get(Uri.parse(url + "api/v1/applies"), headers: headers);
    if (response.statusCode == 200) {
      var list = parseCastingAppliesList(response.body);
      return list;
    } else {
      throw Exception("ERROR at getCastingAppliesList");
    }
  }

  List<ApplyList> parseCastingAppliesList(String responseBody) {
    int count = 0;
    var list = jsonDecode(responseBody);
    List<ApplyList> castingApplies = new List<ApplyList>();
    list['applyList'].map((e) => count++).toList();
    for (int i = 0; i < count; i++) {
      castingApplies.add(ApplyList.fromJson(list['applyList'][i]));
    }
    return castingApplies;
  }

  Future<List<ResultList>> getCastingResultList() async {
    var jwt = (await FlutterSession().get("jwt")).toString();
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
      'Authorization': 'Bearer ' + jwt
    };

    final response = await http.get(Uri.parse(url + "api/v1/results/model"),
        headers: headers);
    if (response.statusCode == 200) {
      var list = parseCastingResultList(response.body);
      return list;
    } else {
      throw Exception("ERROR at getCastingResultList");
    }
  }

  List<ResultList> parseCastingResultList(String responseBody) {
    int count = 0;
    var list = jsonDecode(responseBody);
    List<ResultList> castingResult = new List<ResultList>();
    list['resultList'].map((e) => count++).toList();
    for (int i = 0; i < count; i++) {
      castingResult.add(ResultList.fromJson(list['resultList'][i]));
    }
    return castingResult;
  }
}
