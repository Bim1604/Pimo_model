import 'package:pimo/models/availible.dart';

class AvailibleViewModel {
  final Availible _availible;
  AvailibleViewModel({Availible availible}) : _availible = availible;

  int get id {
    return _availible.id;
  }

  String get startDate {
    return _availible.startDate;
  }

  String get endDate {
    return _availible.endDate;
  }

  String get location {
    return _availible.location;
  }
}
