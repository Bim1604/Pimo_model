import 'package:flutter/cupertino.dart';
import 'package:pimo/models/casting_result.dart';
import 'package:pimo/services/casting_service.dart';
import 'package:pimo/viewmodels/casting_result_view_model.dart';

class CastingResultListViewModel with ChangeNotifier {
  List<CastingResultViewModel> listCastResult = new List<CastingResultViewModel>();

  Future<CastingResultListViewModel> getCastingResultList() async {
    print('Hello');
    List<ResultList> list = await CastingService().getCastingResultList();
    notifyListeners();
    this.listCastResult =
        list.map((value) => CastingResultViewModel(resultList: value)).toList();
  }
}