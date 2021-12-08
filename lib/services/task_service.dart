
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:pimo/constants/Images.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:http/http.dart' as http;
import 'package:pimo/models/task_list_info.dart';
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';
import 'package:pimo/viewmodels/task_list_view_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
class TaskService {

  List<TaskList> parseTaskList(String responseBody) {
    int count = 0;
    var list = jsonDecode(responseBody);
    List<TaskList> taskList = new List<TaskList>();
    list['taskList'].map((e) => count++).toList();
    for (int i = 0; i < count; i++) {
      taskList.add(TaskList.fromJson(list['taskList'][i]));
    }
    return taskList;
  }

  Future<List<TaskList>> getTaskList() async {
    var jwt = (await FlutterSession().get("jwt")).toString();
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
      'Authorization': 'Bearer ' + jwt
    };
    final response = await http
        .get(Uri.parse(url + "api/v1/tasks/model") ,headers: headers);
    if (response.statusCode == 200) {
      var list = parseTaskList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<bool> createFreeTime(Map<String, dynamic> params) async {
    var token = (await FlutterSession().get("token")).toString();
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    heads['Authorization'] = 'Bearer $token';
    final message = jsonEncode(params);
    final response = await http.post(
        Uri.parse(
            url + 'api/v1/tasks/free-time'),
        body: message,
        headers: heads);
    if (response.statusCode == 200) {
      // var responseBody = Task.fromJson(jsonDecode(response.body));
      // return responseBody;
      Fluttertoast.showToast(msg: 'Tạo lịch thành công');
      return true;
    } else {
      Fluttertoast.showToast(msg: 'Tạo lịch thất bại');
      return false;
    }
  }

  Future<List<TaskList>> getIncomingTaskList(int castingId) async {
    var token = (await FlutterSession().get("token")).toString();
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    heads['Authorization'] = 'Bearer $token';
    var modelId = (await FlutterSession().get("modelId")).toString();
    final response = await http
        .get(Uri.parse(url + "api/v1/tasks/$modelId/$castingId/task"));
    if (response.statusCode == 200) {
      var list = parseTaskList(response.body);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }

}

List<Appointment> getAppointment(TaskListViewModel list) {
  List<Appointment> task = <Appointment>[];
  for (int i = 0; i < list.listTask.length; i++) {
    task.add(Appointment(
        // startTime: list.listTask[i].task.startDate,
        // endTime: list.listTask[i].task.endDate.,
        color: MaterialColors.mainColor,
        subject: list.listTask[i].casting.name == null
            ? 'Free time'
            : list.listTask[i].casting.name));
  }
  return task;
}
class TaskDataSource extends CalendarDataSource {
  TaskDataSource(List<Appointment> source) {
    appointments = source;
  }
}