class ImageCollectionTest {
  int id;
  String name;
  String description;
  int brandId;
  int modelId;
  int collectionId;

  ImageCollectionTest(
      {this.id,
      this.name,
      this.description,
      this.brandId,
      this.modelId,
      this.collectionId});

  factory ImageCollectionTest.fromJson(Map<String, dynamic> json) {
    return ImageCollectionTest(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      brandId: json['brandId'],
      modelId: json['modelId'],
      collectionId: json['collectionId'],
    );
  }
}
