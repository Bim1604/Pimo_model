

import 'package:pimo/models/casting.dart';
import 'package:pimo/models/casting_result.dart';
import 'package:pimo/utils/common.dart';

class CastingResultViewModel {
  ResultList _resultList;
  CastingResultViewModel({ResultList resultList}) : _resultList = resultList;

  Casting get casting {
    return _resultList.casting;
  }

  String get castingResultStartDate {
    return _resultList.casting.openTime != null ? formatDateAndTime(_resultList.casting.openTime) : 'null';
  }

  String get castingResultEndDate {
    return _resultList.casting.closeTime != null ? formatDateAndTime(_resultList.casting.closeTime) : 'null';
  }
}