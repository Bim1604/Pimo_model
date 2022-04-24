import 'package:flutter/cupertino.dart';
import 'package:pimo/models/collection_project.dart';
import 'package:pimo/services/collection_service.dart';
import 'collection_project_view_model.dart';

class ListCollectionProjectListViewModel with ChangeNotifier {
  List<CollectionProjectViewModel> listCollectionProject =
      new List<CollectionProjectViewModel>();

  Future<ListCollectionProjectListViewModel> getListCollectionProject(
      String modelId) async {
    List<ListCollectionProject> collectionProject =
        await CollectionService().fetchListCollectionProject(modelId);
    notifyListeners();
    this.listCollectionProject = collectionProject
        .map(
            (value) => CollectionProjectViewModel(listCollectionProject: value))
        .toList();
  }
}
