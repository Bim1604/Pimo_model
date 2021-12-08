import 'brand.dart';

class Casting {
  int id;
  String name;
  String description;
  bool status;
  String openTime;
  String closeTime;
  int brandId;
  String address;
  int salary;
  String request;
  String poster;
  Brand brand;

  Casting(
      {this.id,
        this.name,
        this.description,
        this.status,
        this.openTime,
        this.closeTime,
        this.brandId,
        this.address,
        this.salary,
        this.request,
        this.poster,
        this.brand});

  Casting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    openTime = json['openTime'];
    closeTime = json['closeTime'];
    brandId = json['brandId'];
    address = json['address'];
    salary = json['salary'];
    request = json['request'];
    poster = json['poster'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['openTime'] = this.openTime;
    data['closeTime'] = this.closeTime;
    data['brandId'] = this.brandId;
    data['address'] = this.address;
    data['salary'] = this.salary;
    data['request'] = this.request;
    data['poster'] = this.poster;
    if (this.brand != null) {
      data['brand'] = this.brand.toJson();
    }
    return data;
  }
}
