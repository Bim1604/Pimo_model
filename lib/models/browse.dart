import 'package:pimo/models/casting_browse.dart';

import 'casting.dart';
import 'model.dart';

class Browse {
  int modelId;
  int castingId;
  bool status;
  Casting casting;
  ModelBrowses modelBrowses;

  Browse(
      {this.modelId,
        this.castingId,
        this.status,
        this.casting,
        this.modelBrowses});

  Browse.fromJson(Map<String, dynamic> json) {
    modelId = json['modelId'];
    castingId = json['castingId'];
    status = json['status'];
    casting =
    json['casting'] != null ? new Casting.fromJson(json['casting']) : null;
    modelBrowses = json['modelBrowses'] != null
        ? new ModelBrowses.fromJson(json['modelBrowses'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['modelId'] = this.modelId;
    data['castingId'] = this.castingId;
    data['status'] = this.status;
    if (this.casting != null) {
      data['casting'] = this.casting.toJson();
    }
    if (this.modelBrowses != null) {
      data['modelBrowses'] = this.modelBrowses.toJson();
    }
    return data;
  }
}
