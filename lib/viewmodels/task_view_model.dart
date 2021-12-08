

import 'package:pimo/models/casting.dart';
import 'package:pimo/models/task.dart';
import 'package:pimo/models/task_list_info.dart';
import 'package:pimo/utils/common.dart';

class TaskViewModel {
  TaskList _taskList;
  TaskViewModel({TaskList taskList}) : _taskList = taskList;

  Task get task {
    return _taskList.task;
  }

  Casting get casting {
    return _taskList.casting;
  }

  String get taskStartDate {
    return _taskList.task.startDate != null ? formatDateAndTime(_taskList.task.startDate) : 'null';
  }

  String get taskEndDate {
    return _taskList.task.endDate != null ? formatDateAndTime(_taskList.task.endDate) : 'null';
  }
}