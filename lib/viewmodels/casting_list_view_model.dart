import 'package:flutter/widgets.dart';
import 'package:pimo/models/casting.dart';
import 'package:pimo/models/casting_info.dart';
import 'package:pimo/services/apply_casting_service.dart';
import 'package:pimo/services/casting_service.dart';
import 'package:pimo/utils/common.dart';

import 'casting_view_model.dart';

class CastingListViewModel with ChangeNotifier {
  List<CastingViewModel> castings = List<CastingViewModel>();

  void topHeadlines() async {
    List<Casting> list = [];
    list = await CastingService().searchCastingList('', '', '');
    notifyListeners();
    this.castings = list
        .where((item) =>
            parseDatetime(item.openTime).isBefore(DateTime.now()) &&
            parseDatetime(item.closeTime).isAfter(DateTime.now()))
        .map((casting) => CastingViewModel(casting: casting))
        .toList();
    this.castings.sort((a, b) => a.openDate.compareTo(b.openDate));
  }

  Future<CastingListViewModel> searchCastingList(
      String name, String min, String max) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      List<Casting> list =
          await CastingService().searchCastingList(name, min, max);
      notifyListeners();
      this.castings =
          list.map((casting) => CastingViewModel(casting: casting)).toList();
    });
  }

  Future<CastingListViewModel> modelApplyCasting() async {
    return Future.delayed(const Duration(seconds: 1), () async {
      List<Casting> list = await CastingService().modelApplyCasting();
      notifyListeners();
      this.castings =
          list.map((casting) => CastingViewModel(casting: casting)).toList();
    });
  }

  // Future<CastingListViewModel> castingByIds(List<int> castings) async {
  //   return Future.delayed(const Duration(seconds: 1), () async {
  //     List<Casting> list = await CastingService().getCastingByIds(castings);
  //     notifyListeners();
  //     this.castings =
  //         list.map((casting) => CastingViewModel(casting: casting)).toList();
  //   });
  // }

  Future<CastingListViewModel> incomingCasting() async {
    return Future.delayed(const Duration(seconds: 1), () async {
      List<Casting> list = await CastingService().getIncomingCasting();
      notifyListeners();
      this.castings =
          list.map((casting) => CastingViewModel(casting: casting)).toList();
      this.castings.sort((a, b) => a.openDate.compareTo(b.openDate));
    });
  }

  Future<CastingListViewModel> applyCasting(int castingId) async {
    return Future.delayed(const Duration(seconds: 1), () async {
      List<Casting> list =
          await ApplyCastingService().createApplyCasting(castingId);
      notifyListeners();
      this.castings =
          list.map((casting) => CastingViewModel(casting: casting)).toList();
      this.castings.sort((a, b) => a.openDate.compareTo(b.openDate));
    });
  }

  // Future<CastingListViewModel> cancelCasting(int castingId) async {
  //   return Future.delayed(const Duration(seconds: 1), () async {
  //     List<Casting> list = await ApplyCastingService().deleteApplyCasting(castingId);
  //     notifyListeners();
  //     this.castings =
  //         list.map((casting) => CastingViewModel(casting: casting)).toList();
  //     this.castings.sort((a, b) => a.openDate.compareTo(b.openDate));
  //   });
  // }
}
