import 'package:flutter/cupertino.dart';
import 'package:pimo/models/collection_bodypart.dart';
import 'package:pimo/services/collection_service.dart';
import 'collection_bodypart_view_model.dart';


class ListCollectionBodyPartListViewModel with ChangeNotifier {

  List<CollectionBodyPartViewModel> listCollectionBodyPart = new List<CollectionBodyPartViewModel>();

  Future<ListCollectionBodyPartListViewModel> getListCollectionBodyPart(String modelId) async {
    List<ListCollectionBodyPart> collectionBodyPart = await CollectionService().fetchListCollectionBodyPart(modelId);
    notifyListeners();
    listCollectionBodyPart = collectionBodyPart.map((value)
      => CollectionBodyPartViewModel(listCollectionBodyPart: value)).toList();
  }
}

