import 'package:pimo/models/project.dart';

import 'brand.dart';
import 'collection.dart';
import 'image.dart';

class ListCollectionProject {
  Collection collection;
  List<ModelImage> imageList;
  Project project;
  Brand brand;

  ListCollectionProject(
      {this.collection, this.imageList, this.project, this.brand});

  ListCollectionProject.fromJson(Map<String, dynamic> json) {
    collection = json['collection'] != null
        ? new Collection.fromJson(json['collection'])
        : null;
    if (json['imageList'] != null) {
      imageList = new List<ModelImage>();
      json['imageList'].forEach((v) {
        imageList.add(new ModelImage.fromJson(v));
      });
    }
    project =
    json['project'] != null ? new Project.fromJson(json['project']) : null;
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collection != null) {
      data['collection'] = this.collection.toJson();
    }
    if (this.imageList != null) {
      data['imageList'] = this.imageList.map((v) => v.toJson()).toList();
    }
    if (this.project != null) {
      data['project'] = this.project.toJson();
    }
    if (this.brand != null) {
      data['brand'] = this.brand.toJson();
    }
    return data;
  }
}
