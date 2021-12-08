import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/utils/result_card.dart';
import 'package:pimo/utils/task_card.dart';
import 'package:pimo/viewmodels/casting_list_view_model.dart';
import 'package:pimo/viewmodels/casting_result_list_view_model.dart';
import 'package:pimo/viewmodels/task_list_view_model.dart';
import 'package:provider/provider.dart';

class ModelTaskPage extends StatefulWidget {
  ModelTaskPage({Key key}) : super(key: key);

  @override
  _ModelTaskPageState createState() => _ModelTaskPageState();
}

class _ModelTaskPageState extends State<ModelTaskPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: MaterialColors.mainColor,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      text: 'Kết quả',
                    ),
                    Tab(text: 'Nhiệm vụ'),
                  ],
                  indicatorColor: Colors.black,
                  indicatorWeight: 3,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black.withOpacity(0.8),
                ),
                title: Text('Nhiệm vụ'),
              ),
              body: TabBarView(
                children: [
                  SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 100),
                            child: SizedBox(
                              height: height - 162,
                              child: FutureBuilder<CastingResultListViewModel>(
                                  future: Provider.of<CastingResultListViewModel>(context,
                                      listen: false)
                                      .getCastingResultList(),
                                  builder: (context, data) {
                                    if (data.connectionState ==
                                        ConnectionState.waiting) {
                                      return Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 150,
                                          ),
                                          Center(child: CircularProgressIndicator()),
                                        ],
                                      );
                                    } else {
                                      if (data.error == null) {
                                        return Consumer<CastingResultListViewModel>(
                                            builder: (ctx, data, child) =>
                                                CastingResultComponent(
                                                  castingResult: data,
                                                ));
                                      } else {
                                        return Center(
                                          child: SizedBox(
                                            child: Text('Chưa có kết quả nào'),
                                          ),
                                        );
                                      }
                                    }
                                  }),
                            ),
                          )
                        ],
                      )),
                  SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 100),
                            child: SizedBox(
                              height: height - 162,
                              child: FutureBuilder<TaskListViewModel>(
                                  future: Provider.of<TaskListViewModel>(context,
                                      listen: false)
                                      .getTaskListViewModel(),
                                  builder: (context, data) {
                                    if (data.connectionState ==
                                        ConnectionState.waiting) {
                                      return Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 150,
                                          ),
                                          Center(child: CircularProgressIndicator()),
                                        ],
                                      );
                                    } else {
                                      if (data.error == null) {
                                        return Consumer<TaskListViewModel>(
                                            builder: (ctx, data, child) =>
                                               TaskListComponent(
                                                  taskInfo: data,
                                                ));
                                      } else {
                                        return Center(
                                          child: SizedBox(
                                            child: Text(
                                                'Bạn chưa đăng kí bất kì nhiệm vụ nào !'),
                                          ),
                                        );
                                      }
                                    }
                                  }),
                            ),
                          )
                        ],
                      )),
                ],
              )),
        ));
  }
}

