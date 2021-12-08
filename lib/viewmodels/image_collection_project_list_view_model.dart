import 'package:flutter/cupertino.dart';
import 'package:pimo/models/image_collection.dart';
import 'package:pimo/services/image_collection_project_service.dart';
import 'image_collection_view_model.dart';

class ImageCollectionProjectListViewModel with ChangeNotifier {
  List<ImageCollectionViewModel> imageCollections =
      List<ImageCollectionViewModel>();

  Future<ImageCollectionProjectListViewModel> getImageCollectionList() async {
    List<ImageCollectionTest> list =
        await ImageCollectionProjectService().fetchImageCollection();
    notifyListeners();
    imageCollections = list
        .map((collections) =>
            ImageCollectionViewModel(imageCollection: collections))
        .toList();
  }
}
