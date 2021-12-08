
import 'package:pimo/models/browse.dart';
import 'package:pimo/models/casting.dart';
import 'package:pimo/models/casting_browse.dart';
import 'package:pimo/models/model.dart';

class CastingBrowseViewModel {
  CastingBrowses _castingBrowses;
  CastingBrowseViewModel({CastingBrowses casting}) : _castingBrowses = casting;

  Browse get browse {
    return _castingBrowses.browse;
  }

  Casting get casting {
    return _castingBrowses.casting;
  }

  ModelBrowses get model {
    return _castingBrowses.modelBrowses;
  }

}