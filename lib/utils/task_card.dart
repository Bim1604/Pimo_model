import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/screens/task_detail.dart';
import 'package:pimo/viewmodels/casting_list_view_model.dart';
import 'package:pimo/viewmodels/task_list_view_model.dart';
import 'package:pimo/viewmodels/task_view_model.dart';
import 'package:provider/provider.dart';

class TaskListComponent extends StatefulWidget {

  final TaskListViewModel taskInfo;
  TaskListComponent({Key key, this.taskInfo}) : super(key: key);

  @override
  TaskListComponentState createState() =>  TaskListComponentState();
}

class  TaskListComponentState extends State<TaskListComponent> {
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: widget.taskInfo.listTask.length,
      itemBuilder: (context, index) {
        return TaskCard(task: widget.taskInfo.listTask[index]);
      },
    );
  }
}

class TaskCard extends StatelessWidget {
  final TaskViewModel task;
  const TaskCard({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> requestList = List<String>();
    if (task.casting.request.isNotEmpty) {
      var listRequest = task.casting.request.split("<br/>");
      for (var i = 1; i < listRequest.length; i++) {
        requestList.add(listRequest[i].toString());
      }
    } else {
      requestList.add("Không có yêu cầu.");
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                        create: (_) => CastingListViewModel()),
                  ],
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      return TaskDetailPage(
                        taskInfo: task,
                      );
                    },
                  ))),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: MaterialColors.mainColor.withOpacity(0.5),
                offset: Offset(0, 5),
                blurRadius: 10,
              )
            ]),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    task.casting.name?? '',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
                Container(
                    child: Expanded(
                      child: Text(
                        task.casting.status ?  'Đang thực hiện' : 'Hoàn thành' ,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: task.casting.status == true
                            ? Colors.green
                            : task.casting.status == false
                            ? Colors.grey[800]
                            : Colors.redAccent)
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  task.casting.salary.toString()+ " VNĐ"?? '',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.amberAccent),
                ),
              ],
            ),
            Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.all(2),
                itemCount: requestList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                     requestList[index] ?? '',
                    softWrap: false,
                  );
                },

              ),
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            Row(
              children: [
                Text('Bắt đầu: '),
                Text(
                  task.taskStartDate ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Text('Kết thúc: '),
                Text(
                  task.taskStartDate ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}