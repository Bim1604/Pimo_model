class Styles {
  String name;
  Styles({this.name});

  Styles.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}
