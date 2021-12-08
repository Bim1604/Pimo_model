import 'package:pimo/models/model_style.dart';

import 'brand.dart';
import 'casting.dart';

class CastingInfo {
  Casting casting;
  List<ListStyle> listStyle;
  List<ListGender> listGender;
  Brand brand;

  CastingInfo({this.casting, this.listStyle, this.listGender, this.brand});

  CastingInfo.fromJson(Map<String, dynamic> json) {
    casting =
    json['casting'] != null ? new Casting.fromJson(json['casting']) : null;
    if (json['listStyle'] != null) {
      listStyle = new List<ListStyle>();
      json['listStyle'].forEach((v) {
        listStyle.add(new ListStyle.fromJson(v));
      });
    }
    if (json['listGender'] != null) {
      listGender = new List<ListGender>();
      json['listGender'].forEach((v) {
        listGender.add(new ListGender.fromJson(v));
      });
    }
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.casting != null) {
      data['casting'] = this.casting.toJson();
    }
    if (this.listStyle != null) {
      data['listStyle'] = this.listStyle.map((v) => v.toJson()).toList();
    }
    if (this.listGender != null) {
      data['listGender'] = this.listGender.map((v) => v.toJson()).toList();
    }
    if (this.brand != null) {
      data['brand'] = this.brand.toJson();
    }
    return data;
  }
}

class ListStyle {
  int id;
  String name;
  List<ModelStyle> modelStyles;

  ListStyle({this.id, this.name, this.modelStyles});

  ListStyle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['modelStyles'] != null) {
      modelStyles = new List<Null>();
      json['modelStyles'].forEach((v) {
        // modelStyles.add(new ModelStyle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.modelStyles != null) {
      // data['modelStyles'] = this.modelStyles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListGender {
  int id;
  String genderName;

  ListGender({this.id, this.genderName});

  ListGender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    genderName = json['genderName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['genderName'] = this.genderName;
    return data;
  }
}
