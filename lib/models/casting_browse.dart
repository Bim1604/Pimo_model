import 'browse.dart';
import 'casting.dart';
import 'model.dart';

class CastingBrowsesInfo {
  List<CastingBrowses> castingBrowses;

  CastingBrowsesInfo({this.castingBrowses});

  CastingBrowsesInfo.fromJson(Map<String, dynamic> json) {
    if (json['castingBrowses'] != null) {
      castingBrowses = new List<CastingBrowses>();
      json['castingBrowses'].forEach((v) {
        castingBrowses.add(new CastingBrowses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.castingBrowses != null) {
      data['castingBrowses'] =
          this.castingBrowses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CastingBrowses {
  Browse browse;
  ModelBrowses modelBrowses;
  Casting casting;

  CastingBrowses({this.browse, this.modelBrowses, this.casting});

  CastingBrowses.fromJson(Map<String, dynamic> json) {
    browse =
    json['browse'] != null ? new Browse.fromJson(json['browse']) : null;
    modelBrowses = json['model'] != null
        ? new ModelBrowses.fromJson(json['model'])
        : null;
    casting =
    json['casting'] != null ? new Casting.fromJson(json['casting']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.browse != null) {
      data['browse'] = this.browse.toJson();
    }
    if (this.modelBrowses != null) {
      data['model'] = this.modelBrowses.toJson();
    }
    if (this.casting != null) {
      data['casting'] = this.casting.toJson();
    }
    return data;
  }
}


class ModelBrowses {
  int id;
  String name;
  int genderId;
  String dateOfBirth;
  String country;
  String province;
  String district;
  String phone;
  String mail;
  String avatar;
  bool status;
  String gifted;
  String description;
  String instagram;
  String twitter;
  String facebook;
  int gender;

  ModelBrowses(
      {this.id,
        this.name,
        this.genderId,
        this.dateOfBirth,
        this.country,
        this.province,
        this.district,
        this.phone,
        this.mail,
        this.avatar,
        this.status,
        this.gifted,
        this.description,
        this.instagram,
        this.twitter,
        this.facebook,
        this.gender});

  ModelBrowses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    genderId = json['genderId'];
    dateOfBirth = json['dateOfBirth'];
    country = json['country'];
    province = json['province'];
    district = json['district'];
    phone = json['phone'];
    mail = json['mail'];
    avatar = json['avatar'];
    status = json['status'];
    gifted = json['gifted'];
    description = json['description'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    facebook = json['facebook'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['genderId'] = this.genderId;
    data['dateOfBirth'] = this.dateOfBirth;
    data['country'] = this.country;
    data['province'] = this.province;
    data['district'] = this.district;
    data['phone'] = this.phone;
    data['mail'] = this.mail;
    data['avatar'] = this.avatar;
    data['status'] = this.status;
    data['gifted'] = this.gifted;
    data['description'] = this.description;
    data['instagram'] = this.instagram;
    data['twitter'] = this.twitter;
    data['facebook'] = this.facebook;
    data['gender'] = this.gender;
    return data;
  }
}


