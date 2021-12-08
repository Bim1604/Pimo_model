import 'package:pimo/models/collection.dart';
import 'package:pimo/models/collection_project.dart';
import 'package:pimo/models/image.dart';

class CollectionProjectViewModel  {

  ListCollectionProject _listCollectionProject;
  CollectionProjectViewModel({ListCollectionProject listCollectionProject}) : _listCollectionProject = listCollectionProject;

  String get nameCollection {
    return _listCollectionProject.collection.name;
  }

  int get idCollection {
    return _listCollectionProject.collection.id;
  }

  List<ModelImage> get listImage {
    return _listCollectionProject.imageList;
  }

  int get listImageLength {
    return _listCollectionProject.imageList.length;
  }

  Object get project {
    return _listCollectionProject.project;
  }


}