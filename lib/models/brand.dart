class Brand {
  int id;
  String name;
  String description;
  bool status;
  int brandCateId;
  String mail;
  String address;
  String phone;
  String logo;
  String brandCate;

  Brand(
      {this.id,
      this.name,
      this.description,
      this.status,
      this.brandCateId,
      this.mail,
      this.address,
      this.phone,
      this.logo,
      this.brandCate});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    brandCateId = json['brandCateId'];
    mail = json['mail'];
    address = json['address'];
    phone = json['phone'];
    logo = json['logo'];
    brandCate = json['brandCate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['brandCateId'] = this.brandCateId;
    data['mail'] = this.mail;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['logo'] = this.logo;
    data['brandCate'] = this.brandCate;
    return data;
  }
}
