
import 'package:intl/intl.dart';
import 'package:pimo/models/image.dart';
class ModelImageViewModel {
  ModelImage _image;

  ModelImageViewModel({ModelImage image}) : _image = image;

  int get id {
    return _image.id;
  }

  String get fileName {
    return _image.fileName;
  }

  int get collectionId {
    return _image.collectionId;
  }

  bool get status {
    return _image.status;
  }

  String get uploadDate {
    return _image.uploadDate != null ? formatDate(_image.uploadDate) : 'null';
  }

  String formatDate(String date) {
    DateTime dt = DateTime.parse(date);
    var formatter = new DateFormat('dd-MM-yyyy');
    return formatter.format(dt);
  }
}