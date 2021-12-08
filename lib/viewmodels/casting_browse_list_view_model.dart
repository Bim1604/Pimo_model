

import 'package:flutter/material.dart';
import 'package:pimo/models/casting_browse.dart';
import 'package:pimo/services/casting_service.dart';
import 'package:pimo/viewmodels/casting_browse_view_model.dart';

class CastingBrowseListViewModel with ChangeNotifier {
  List<CastingBrowseViewModel> listCastingBrowse = new List<CastingBrowseViewModel>();

  Future<CastingBrowseListViewModel> getCastingBrowseList() async {
    List<CastingBrowses> list = await CastingService().getCastingBrowseList();
    notifyListeners();
    this.listCastingBrowse = list.map((value) => CastingBrowseViewModel(casting: value)).toList();
  }
}