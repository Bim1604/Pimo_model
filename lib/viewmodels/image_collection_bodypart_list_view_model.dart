import 'package:flutter/cupertino.dart';
import 'package:pimo/models/image_collection.dart';
import 'package:pimo/services/image_collection_bodypart_service.dart';
import 'image_collection_view_model.dart';

class ImageCollectionBodyPartListViewModel with ChangeNotifier {
  List<ImageCollectionViewModel> imageCollections =
      List<ImageCollectionViewModel>();

  Future<ImageCollectionBodyPartListViewModel> getImageCollectionList() async {
    List<ImageCollectionTest> list =
        await ImageCollectionBodyPartService().fetchImageCollection();
    notifyListeners();
    this.imageCollections = list
        .map((collections) =>
            ImageCollectionViewModel(imageCollection: collections))
        .toList();
  }
}
