class ModelImage {
  int id;
  String fileName;
  int collectionId;
  String uploadDate;
  bool status;

  ModelImage(
      {this.id,
        this.fileName,
        this.collectionId,
        this.uploadDate,
        this.status});

  ModelImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['fileName'];
    collectionId = json['collectionId'];
    uploadDate = json['uploadDate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fileName'] = this.fileName;
    data['collectionId'] = this.collectionId;
    data['uploadDate'] = this.uploadDate;
    data['status'] = this.status;
    return data;
  }
}