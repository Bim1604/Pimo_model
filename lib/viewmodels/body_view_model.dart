import 'package:pimo/models/body.dart';

class BodyPartViewModel {
  BodyPart _bodyPart;
  BodyPartViewModel({BodyPart bodyPart}) : _bodyPart = bodyPart;

  String get name {
    return _bodyPart.text;
  }

  String get measure {
    if (_bodyPart.value.measure == null) {
      return 'Không có';
    }
    return _bodyPart.value.measure;
  }

  String get textValue {
    return _bodyPart.value.textValue;
  }

  double get quantity {
    return _bodyPart.value.quantityValue;
  }
}
