import 'package:flutter/cupertino.dart';
import 'package:pimo/models/casting_applies.dart';
import 'package:pimo/services/casting_service.dart';
import 'package:pimo/viewmodels/casting_applies_view_model.dart';
import 'package:pimo/viewmodels/casting_browse_view_model.dart';

class CastingAppliesListViewModel with ChangeNotifier {
  List<CastingAppliesViewModel> listCastingApplies = new List<CastingAppliesViewModel>();

  Future<CastingAppliesListViewModel> getCastingAppliesList() async {
    List<ApplyList> list = await CastingService().getCastingAppliesList();
    notifyListeners();
    this.listCastingApplies = list.map((value) => CastingAppliesViewModel(castingApplies: value)).toList();
  }
}