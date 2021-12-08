import 'package:flutter/cupertino.dart';
import 'package:pimo/models/body.dart';
import 'package:pimo/models/styles.dart';
import 'package:pimo/services/body_service.dart';
import 'package:pimo/services/styles_service.dart';
import 'package:pimo/viewmodels/body_view_model.dart';
import 'package:pimo/viewmodels/styles_view_model.dart';

class BodyPartListViewModel with ChangeNotifier {
  List<BodyPartViewModel> listBodyPart = new List<BodyPartViewModel>();
  List<StylesViewModel> listStyles = new List<StylesViewModel>();

  Future<BodyPartListViewModel> getListBodyPart(int modelId) async {
    List<BodyPart> list = await BodyPartService().getBodyPartList(modelId);
    notifyListeners();
    this.listBodyPart =
        list.map((value) => BodyPartViewModel(bodyPart: value)).toList();
  }

  Future<BodyPartListViewModel> getListStyles(int modelId) async {
    List<Styles> list = await StylesService().getStylesList(modelId);
    notifyListeners();
    this.listStyles =
        list.map((value) => StylesViewModel(styles: value)).toList();
  }
}
