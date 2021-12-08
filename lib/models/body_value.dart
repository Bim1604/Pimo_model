class BodyValue {
  String measure;
  int quantityValue;
  String textValue;

  BodyValue({this.measure, this.quantityValue, this.textValue});

  BodyValue.fromJson(Map<String, dynamic> json) {
    measure = json['measure'];
    quantityValue = json['quantityValue'];
    textValue = json['textValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['measure'] = this.measure;
    data['quantityValue'] = this.quantityValue;
    data['textValue'] = this.textValue;
    return data;
  }
}