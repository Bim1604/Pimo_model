class Project {
  int id;
  String name;
  String description;
  int brandId;
  int modelId;

  Project(
      {this.id,
        this.name,
        this.description,
        this.brandId,
        this.modelId});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    brandId = json['brandId'];
    modelId = json['modelId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['brandId'] = this.brandId;
    data['modelId'] = this.modelId;
    return data;
  }
}