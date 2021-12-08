import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/utils/incoming_casting_applies_component.dart';
import 'package:pimo/viewmodels/casting_applies_list_view_model.dart';
import 'package:pimo/viewmodels/casting_browse_list_view_model.dart';
import 'package:pimo/viewmodels/task_list_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/incoming_casting_list_component.dart';
import 'model_schedule.dart';

class IncomingCastingPage extends StatelessWidget {
  const IncomingCastingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Chiến dịch'),
            backgroundColor: MaterialColors.mainColor,
            bottom: TabBar(
              tabs: const [
                Tab(text: 'Đã ứng tuyển'),
                Tab(text: 'Đã được duyệt')
              ],
              indicatorColor: Colors.black,
              indicatorWeight: 3,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black.withOpacity(0.8),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  child: Icon(Icons.schedule),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiProvider(
                                  providers: [
                                    ChangeNotifierProvider(
                                        create: (_) => TaskListViewModel()),
                                  ],
                                  child: FutureBuilder(
                                    builder: (context, snapshot) {
                                      return ModelSchedulePage();
                                    },
                                  ))),
                    );
                  },
                ),
              )
            ],
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
                      child: FutureBuilder<CastingAppliesListViewModel>(
                          future: Provider.of<CastingAppliesListViewModel>(
                                  context,
                                  listen: false)
                              .getCastingAppliesList(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
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
                              if (snapshot.error == null) {
                                return Consumer<CastingAppliesListViewModel>(
                                    builder: (ctx, data, child) =>
                                        IncomingAppliesListComponent(
                                          listApplies: data,
                                        ));
                              } else {
                                return Center(
                                  child: SizedBox(
                                    child: Center(
                                      child: Text('Không Có lịch đặt'),
                                    ),
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
                      child: FutureBuilder<CastingBrowseListViewModel>(
                          future: Provider.of<CastingBrowseListViewModel>(
                                  context,
                                  listen: false)
                              .getCastingBrowseList(),
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
                                return Consumer<CastingBrowseListViewModel>(
                                    builder: (ctx, data, child) =>
                                        IncomingCastingListComponent(
                                          listBrowse: data,
                                        ));
                              } else {
                                return Center(
                                  child: SizedBox(
                                    child: Center(
                                      child: Text('Không có lịch đặt'),
                                    ),
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
