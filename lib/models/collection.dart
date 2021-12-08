class Collection {
  int id;
  String name;
  bool status;
  String description;

  Collection({this.id, this.name, this.status, this.description});

  Collection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['description'] = this.description;
    return data;
  }
}