import 'casting.dart';

class Task {
  int id;
  String startDate;
  String endDate;
  bool status;
  int castingId;
  int modelId;
  double salary;
  Casting casting;

  Task(
      {this.id,
        this.startDate,
        this.endDate,
        this.status,
        this.castingId,
        this.modelId,
        this.salary,
        this.casting,
      });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    status = json['status'];
    castingId = json['castingId'];
    modelId = json['modelId'];
    salary = json['salary'];
    casting =
    json['casting'] != null ? new Casting.fromJson(json['casting']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['status'] = this.status;
    data['castingId'] = this.castingId;
    data['modelId'] = this.modelId;
    data['salary'] = this.salary;
    if (this.casting != null) {
      data['casting'] = this.casting.toJson();
    }
    return data;
  }
}