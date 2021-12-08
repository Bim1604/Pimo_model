import 'casting.dart';

class ResultInfo {
  List<ResultList> resultList;

  ResultInfo({this.resultList});

  ResultInfo.fromJson(Map<String, dynamic> json) {
    if (json['resultList'] != null) {
      resultList = new List<ResultList>();
      json['resultList'].forEach((v) {
        resultList.add(new ResultList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resultList != null) {
      data['resultList'] = this.resultList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultList {
  Casting casting;

  ResultList({this.casting});

  ResultList.fromJson(Map<String, dynamic> json) {
    casting =
    json['casting'] != null ? new Casting.fromJson(json['casting']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.casting != null) {
      data['casting'] = this.casting.toJson();
    }
    return data;
  }
}
