import 'package:pimo/models/casting.dart';
import 'package:pimo/models/casting_browse.dart';

class CastingApplies {
  List<ApplyList> applyList;

  CastingApplies({this.applyList});

  CastingApplies.fromJson(Map<String, dynamic> json) {
    if (json['applyList'] != null) {
      applyList = new List<ApplyList>();
      json['applyList'].forEach((v) {
        applyList.add(new ApplyList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.applyList != null) {
      data['applyList'] = this.applyList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApplyList {
  ModelBrowses model;
  Casting casting;

  ApplyList({this.model, this.casting});

  ApplyList.fromJson(Map<String, dynamic> json) {
    model = json['model'] != null ? new ModelBrowses.fromJson(json['model']) : null;
    casting =
    json['casting'] != null ? new Casting.fromJson(json['casting']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.model != null) {
      data['model'] = this.model.toJson();
    }
    if (this.casting != null) {
      data['casting'] = this.casting.toJson();
    }
    return data;
  }
}

