import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/viewmodels/task_view_model.dart';


class TaskDetailPage extends StatefulWidget {
  final TaskViewModel taskInfo;

  TaskDetailPage({Key key, this.taskInfo}) : super(key: key);

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  @override
  void initState() {
    super.initState();
    // PushNotificationService().initLocal();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chi tiết'),
          backgroundColor: MaterialColors.mainColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(40),
                child: Column(
                  children: [
                    Text(
                      // Name casting
                      widget.taskInfo.casting.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          //Status ?
                          widget.taskInfo.task.status
                              ? 'Đang thực hiện '
                              : 'Hoàn thành',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: widget.taskInfo.task.status == true
                                ? Colors.green
                                : widget.taskInfo.task.status == false
                                    ? Colors.grey[800]
                                    : Colors.redAccent)),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 22, 0),
                          child: Text(
                            'Poster: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                            width: 200,
                            height: 145,
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.06),
                                      spreadRadius: 2,
                                      blurRadius: 1,
                                      offset: Offset(0, 0))
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      widget.taskInfo.casting.poster),
                                  fit: BoxFit.cover,
                                ))),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 90,
                          child: Text(
                            'Bắt đầu: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.event_available,
                                    )),
                                Text(
                                  widget.taskInfo.taskStartDate,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 90,
                          child: Text(
                            'Kết thúc :',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.event_available,
                                    )),
                                Text(
                                  widget.taskInfo.taskEndDate,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 120,
                          child: Text(
                            'Tiền lương :',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                            child: Text(
                          widget.taskInfo.task.salary.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.amberAccent),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Divider(height: 40, thickness: 1),
                    Row(
                      children: [
                        Container(
                          child: Text(
                            'Mô tả:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        widget.taskInfo.task.casting.description,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

