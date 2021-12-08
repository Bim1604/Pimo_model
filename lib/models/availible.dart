class Availible {
  int id;
  String startDate;
  String endDate;
  String location;

  Availible({this.id, this.startDate, this.endDate, this.location});

  Availible.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    location = json['location'];
  }
}
