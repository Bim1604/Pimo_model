import 'package:flutter/cupertino.dart';
import 'package:pimo/models/availible.dart';
import 'package:pimo/services/availible_service.dart';
import 'package:pimo/viewmodels/availible_view_model.dart';

class AvailibleListViewModel with ChangeNotifier {
  List<AvailibleViewModel> listAvailiable = new List<AvailibleViewModel>();

  Future<AvailibleListViewModel> getAvailibleView(int modelId) async {
    List<Availible> list = await AvailibleService().getAvaibleList(modelId);
    notifyListeners();
    this.listAvailiable =
        list.map((value) => AvailibleViewModel(availible: value)).toList();
  }
}
