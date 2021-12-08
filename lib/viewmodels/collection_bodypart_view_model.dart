import 'package:pimo/models/collection.dart';
import 'package:pimo/models/collection_bodypart.dart';
import 'package:pimo/models/image.dart';

class CollectionBodyPartViewModel  {

  ListCollectionBodyPart _listCollectionBodyPart;
  CollectionBodyPartViewModel({ListCollectionBodyPart listCollectionBodyPart}) : _listCollectionBodyPart = listCollectionBodyPart;

  String get nameCollection {
    return _listCollectionBodyPart.collection.name;
  }

  int get idCollection {
    return _listCollectionBodyPart.collection.id;
  }

  List<ModelImage> get listImage {
    return _listCollectionBodyPart.imageList;
  }

  int get listImageLength {
    return _listCollectionBodyPart.imageList.length;
  }

  // Object get bodyPart {
  //   return _listCollectionBodyPart.bodyPartId;
  // }


}