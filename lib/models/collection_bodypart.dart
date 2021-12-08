import 'package:pimo/models/body.dart';
import 'package:pimo/models/project.dart';

import 'brand.dart';
import 'collection.dart';
import 'image.dart';

class ListCollectionBodyPart {
  Collection collection;
  List<ModelImage> imageList;
  // int bodyPartId;
  Brand brand;

  ListCollectionBodyPart(
      {this.collection, this.imageList, 
      // this.bodyPartId, 
       this.brand});

  ListCollectionBodyPart.fromJson(Map<String, dynamic> json) {

    collection = json['collection'] != null
        ? Collection.fromJson(json['collection'])
        : null;
    if (json['imageList'] != null) {
      imageList = new List<ModelImage>();
      json['imageList'].forEach((v) {
        imageList.add(ModelImage.fromJson(v));
      });
    }
    // bodyPartId =
    // json['bodyPartId'] > 0  ? json['bodyPartId'] : 0;
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (collection != null) {
      data['collection'] = collection.toJson();
    }
    if (imageList != null) {
      data['imageList'] = imageList.map((v) => v.toJson()).toList();
    }
    // if (bodyPartId > 0) {
    //   data['bodyPartId'] = bodyPartId;
    // }
    if (brand != null) {
      data['brand'] = brand.toJson();
    }
    return data;
  }
}
