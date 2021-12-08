import 'package:pimo/models/collection.dart';

class CollectionViewModel {
  Collection _collection;

  CollectionViewModel({Collection collection}) : _collection = collection;

  int get id {
    return _collection.id;
  }

  String get name {
    return _collection.name;
  }

  bool get status {
    return _collection.status;
  }

  String get description {
    return _collection.description;
  }
}
