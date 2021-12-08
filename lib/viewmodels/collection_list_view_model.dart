import 'package:flutter/cupertino.dart';
import 'package:pimo/models/collection.dart';
import 'package:pimo/services/collection_service.dart';

import 'collection_view_model.dart';
import 'image_collection_view_model.dart';

class CollectionListViewModel with ChangeNotifier {


  // List<CollectionViewModel> collectionsBody = List<CollectionViewModel>();
  // Future<CollectionListViewModel> getCollectionBodyList() async {
  //   print("Future Collection Body List View");
  //   List<Collection> list = await CollectionService().fetchCollectionBody();
  //   notifyListeners();
  //   this.collectionsBody =
  //       list.map((collections) => CollectionViewModel(collection: collections)).toList();
  // }
  //
  // List<CollectionViewModel> collectionsProject = List<CollectionViewModel>();
  // Future<CollectionListViewModel> getCollectionProjectList() async {
  //   print("Collection Project List View");
  //   List<Collection> list = await CollectionService().fetchCollectionProject();
  //   notifyListeners();
  //   this.collectionsProject =
  //       list.map((collections) => CollectionViewModel(collection: collections)).toList();
  // }

}