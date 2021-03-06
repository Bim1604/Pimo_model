import 'package:pimo/models/casting.dart';
import 'package:pimo/utils/common.dart';

class CastingViewModel {
  Casting _casting;

  CastingViewModel({Casting casting}) : _casting = casting;

  int get id {
    return _casting.id;
  }

  String get name {
    return _casting.name;
  }

  String get description {
    return _casting.description;
  }

  String get openDate {
    return _casting.openTime != null ? formatDate(_casting.openTime) : 'null';
  }

  String get openTime {
    return _casting.openTime != null ? formatTime(_casting.openTime) : 'null';
  }

  DateTime get openTimeDateTime {
    return parseDatetime(_casting.openTime);
  }

  String get closeTime {
    return _casting.closeTime != null ? formatTime(_casting.closeTime) : 'null';
  }

  String get closeDate {
    return _casting.closeTime != null ? formatDate(_casting.closeTime) : 'null';
  }

  DateTime get closeTimeDateTime {
    return parseDatetime(_casting.closeTime);
  }

  bool get status {
    return _casting.status;
  }

  String get salary {
    return formatCurrency(_casting.salary);
  }

  int get brandId {
    return _casting.brandId;
  }

  String get getStatus {
    return getCastingStatus(_casting.openTime, _casting.closeTime);
  }
}
