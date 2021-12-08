import 'package:pimo/models/task_list_info.dart';
import 'package:pimo/services/task_service.dart';
import 'package:flutter/material.dart';
import 'package:pimo/viewmodels/task_view_model.dart';

class TaskListViewModel with ChangeNotifier {

  List<TaskViewModel> listTask = new List<TaskViewModel>();

  Future<TaskListViewModel> getTaskListViewModel() async {
    List<TaskList> list = await TaskService().getTaskList();
    notifyListeners();
    this.listTask = list.map((value) => TaskViewModel(taskList: value)).toList();
  }

}