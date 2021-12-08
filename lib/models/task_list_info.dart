import 'package:pimo/models/task.dart';

import 'casting.dart';

class TaskListInfo {
  List<TaskList> taskList;

  TaskListInfo({this.taskList});

  TaskListInfo.fromJson(Map<String, dynamic> json) {
    if (json['taskList'] != null) {
      taskList = new List<TaskList>();
      json['taskList'].forEach((v) {
        taskList.add(new TaskList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.taskList != null) {
      data['taskList'] = this.taskList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskList {
  Task task;
  Casting casting;

  TaskList({this.task, this.casting});

  TaskList.fromJson(Map<String, dynamic> json) {
    task = json['task'] != null ? new Task.fromJson(json['task']) : null;
    casting =
    json['casting'] != null ? new Casting.fromJson(json['casting']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.task != null) {
      data['task'] = this.task.toJson();
    }
    if (this.casting != null) {
      data['casting'] = this.casting.toJson();
    }
    return data;
  }
}


