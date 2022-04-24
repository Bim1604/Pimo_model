import 'package:pimo/models/image_collection.dart';
import 'package:pimo/models/image_collection.dart';

class ImageCollectionViewModel {
  ImageCollectionTest _imageCollection;

  ImageCollectionViewModel({ImageCollectionTest imageCollection})
      : _imageCollection = imageCollection;

  int get id {
    return _imageCollection.id;
  }

  String get name {
    return _imageCollection.name;
  }
}
