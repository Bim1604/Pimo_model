import 'package:pimo/models/casting.dart';
import 'package:pimo/models/casting_applies.dart';
import 'package:pimo/models/casting_browse.dart';
import 'package:pimo/viewmodels/casting_browse_view_model.dart';

class CastingAppliesViewModel {
  ApplyList _applies ;
  CastingAppliesViewModel({ApplyList castingApplies}) : _applies = castingApplies;

  ModelBrowses get modelBrowse {
    return _applies.model;
  }

  Casting get casting {
    return _applies.casting;
  }
}