import 'package:flutter/material.dart';
import 'package:pimo/models/model.dart';
import 'package:pimo/services/image_service.dart';
import 'package:pimo/services/model_services.dart';
import 'package:pimo/utils/common.dart';

class ModelViewModel with ChangeNotifier {
  Model _model;

  ModelViewModel({Model model}) : _model = model;

  int get id {
    return _model.id;
  }

  set id(int id) {
    this.id = id;
  }

  String get name {
    return _model.name;
  }

  set name(String name) {
    this.name = name;
  }

  int get gender {
    return _model.gender;
  }

  set gender(int gender) {
    this.gender = gender;
  }

  String get dateOfBirth {
    return _model.dateOfBirth;
  }

  String get age {
    return castAge(_model.dateOfBirth);
  }

  set dateOfBirth(String dateOfBirth) {
    this.dateOfBirth = dateOfBirth;
  }

  String get country {
    return _model.country;
  }

  set country(String country) {
    this.country = country;
  }

  String get province {
    return _model.province;
  }

  set province(String province) {
    this.province = province;
  }

  String get district {
    return _model.district;
  }

  set district(String district) {
    this.district = district;
  }

  String get phone {
    return _model.phone;
  }

  set phone(String phone) {
    this.phone = phone;
  }

  String get mail {
    return _model.phone;
  }

  set mail(String mail) {
    this.mail = mail;
  }

  String get gifted {
    return _model.gifted;
  }

  set gifted(String gifted) {
    this.gifted = gifted;
  }

  String get avatar {
    return _model.avatar;
  }

  set avatar(String avatar) {
    this.avatar = avatar;
  }

  String get description {
    return _model.description;
  }

  set description(String description) {
    this.description = description;
  }

  bool get isStatus {
    return _model.status;
  }

  set status(bool status) {
    this.status = status;
  }

  String get genderName {
    return _model.genderName;
  }

  String get facebook {
    return _model.linkFace;
  }

  String get insta {
    return _model.linkIns;
  }

  String get twitter {
    return _model.linkTwitter;
  }

  Future<ModelViewModel> getModel(int modelId) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      Model model = await ModelServices().getModelDetail(modelId);
      notifyListeners();
      this._model = model;
    });
  }

  Future<ModelViewModel> updateProfileModel(Map<String, dynamic> params) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      Model model = await ModelServices().updateModelDetail(params);
      notifyListeners();
      this._model = model;
    });
  }

  Future<ModelViewModel> updateAvatar(String path, int modelId) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      String avt = await uploadFireBase(path, modelId);
      notifyListeners();
      avatar = avt;
    });
  }
}
