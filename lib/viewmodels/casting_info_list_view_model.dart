import 'package:flutter/material.dart';
import 'package:pimo/models/casting_info.dart';
import 'package:pimo/services/casting_service.dart';

import 'casting_info_view_model.dart';

class CastingInfoListViewModel with ChangeNotifier {
  List<CastingInfoViewModel> listCastingInfo = new List<CastingInfoViewModel>();

  Future<CastingInfoListViewModel> getCastingInfoList() async {
    List<CastingInfo> list = await CastingService().getCastingInfoList();
    notifyListeners();
    this.listCastingInfo =
        list.map((value) => CastingInfoViewModel(castingInfo: value)).toList();
  }
}
