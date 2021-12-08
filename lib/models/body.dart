class BodyPart {
  String text;
  Value value;

  BodyPart({this.text, this.value});

  BodyPart.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
  }
}

class Value {
  String measure;
  double quantityValue;
  String textValue;

  Value({this.measure, this.quantityValue, this.textValue});

  Value.fromJson(Map<String, dynamic> json) {
    measure = json['measure'];
    quantityValue = json['quantityValue'];
    textValue = json['textValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['measure'] = this.measure;
    data['quantityValue'] = this.quantityValue.toDouble();
    data['textValue'] = this.textValue;
    return data;
  }
}
