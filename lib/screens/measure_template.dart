// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:pimo/screens/measure_update.dart';
import 'package:pimo/screens/styles_update.dart';
import 'package:pimo/viewmodels/body_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pimo/constants/Theme.dart';

class MeasureTemplatePage extends StatefulWidget {
  final int modelId;
  MeasureTemplatePage({Key key, this.modelId}) : super(key: key);
  @override
  _MeasureTemplatePageState createState() => _MeasureTemplatePageState();
}

class _MeasureTemplatePageState extends State<MeasureTemplatePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: MaterialColors.mainColor,
                  title: Text('Chi tiết cá nhân'),
                  bottom: TabBar(
                    tabs: const [Tab(text: 'Số đo'), Tab(text: 'Phong cách')],
                    indicatorColor: Colors.black,
                    indicatorWeight: 3,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black.withOpacity(0.8),
                  ),
                ),
                body: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: SizedBox(
                                height: height / 1.5,
                                child: FutureBuilder<BodyPartListViewModel>(
                                  future: Provider.of<BodyPartListViewModel>(
                                          context,
                                          listen: false)
                                      .getListBodyPart(widget.modelId),
                                  builder: (ctx, prevData) {
                                    if (prevData.connectionState ==
                                        ConnectionState.waiting) {
                                      return Column(
                                        children: const <Widget>[
                                          SizedBox(
                                            height: 150,
                                          ),
                                          Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        ],
                                      );
                                    } else {
                                      if (prevData.error == null) {
                                        return Consumer<BodyPartListViewModel>(
                                          builder: (ctx, data, child) => Center(
                                              child: ListView.builder(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 30),
                                                  itemCount:
                                                      data.listBodyPart.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return CompButton(
                                                      temp: data
                                                          .listBodyPart[index]
                                                          .name,
                                                      value: data
                                                                  .listBodyPart[
                                                                      index]
                                                                  .quantity !=
                                                              null
                                                          ? data
                                                              .listBodyPart[
                                                                  index]
                                                              .quantity
                                                              .toString()
                                                          : 'Không có',
                                                      measure: data
                                                                  .listBodyPart[
                                                                      index]
                                                                  .measure !=
                                                              null
                                                          ? data
                                                              .listBodyPart[
                                                                  index]
                                                              .measure
                                                              .toString()
                                                          : 'Không có',
                                                    );
                                                  })),
                                        );
                                      } else {
                                        return const Text('Lỗi');
                                      }
                                    }
                                  },
                                )),
                          ),
                          ElevatedButton(
                            child: const Text('Cập nhật',
                                style: TextStyle(color: Colors.black)),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MultiProvider(
                                            providers: [
                                              ChangeNotifierProvider(
                                                create: (_) =>
                                                    BodyPartListViewModel(),
                                              ),
                                            ],
                                            child: FutureBuilder(
                                              builder: (context, snapshot) {
                                                return UpdateMeasureProfilePage(
                                                  modelId: widget.modelId,
                                                );
                                              },
                                            ))),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                primary: MaterialColors.mainColor,
                                elevation: 0,
                                minimumSize: Size(width / 2, 40)),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: SizedBox(
                                height: height / 1.5,
                                child: FutureBuilder<BodyPartListViewModel>(
                                  future: Provider.of<BodyPartListViewModel>(
                                          context,
                                          listen: false)
                                      .getListStyles(widget.modelId),
                                  builder: (ctx, prevData) {
                                    if (prevData.connectionState ==
                                        ConnectionState.waiting) {
                                      return Column(
                                        children: const <Widget>[
                                          SizedBox(
                                            height: 150,
                                          ),
                                          Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        ],
                                      );
                                    } else {
                                      if (prevData.error == null) {
                                        return Consumer<BodyPartListViewModel>(
                                          builder: (ctx, data, child) => Center(
                                              child: ListView.builder(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 30),
                                                  itemCount:
                                                      data.listStyles.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return CompStyleButton(
                                                      temp: data
                                                          .listStyles[index]
                                                          .name,
                                                    );
                                                  })),
                                        );
                                      } else {
                                        return const Text('Lỗi');
                                      }
                                    }
                                  },
                                )),
                          ),
                          ElevatedButton(
                            child: const Text('Cập nhật',
                                style: TextStyle(color: Colors.black)),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MultiProvider(
                                            providers: [
                                              ChangeNotifierProvider(
                                                create: (_) =>
                                                    BodyPartListViewModel(),
                                              ),
                                            ],
                                            child: FutureBuilder(
                                              builder: (context, snapshot) {
                                                return UpdateStylesProfilePage(
                                                  modelId: widget.modelId,
                                                );
                                              },
                                            ))),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                primary: MaterialColors.mainColor,
                                elevation: 0,
                                minimumSize: Size(width / 2, 40)),
                          ),
                        ],
                      ),
                    )
                  ],
                ))));
  }
}

class CompButton extends StatelessWidget {
  final String temp;
  final String value;
  final String measure;
  const CompButton({Key key, this.value, this.measure, this.temp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(-2, 5),
              blurRadius: 10,
              color: Color(0xFFF0F0F0).withOpacity(0.5),
            )
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: MaterialColors.mainColor,
            // width: 2,
          ),
        ),
        child: FlatButton(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  temp +
                      ' - ' +
                      ((value.contains("null")) ? 'Không có' : value) +
                      ' ' +
                      measure,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              SizedBox(
                width: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CompStyleButton extends StatelessWidget {
  final String temp;
  const CompStyleButton({Key key, this.temp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(-2, 5),
              blurRadius: 10,
              color: Color(0xFFF0F0F0).withOpacity(0.5),
            )
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: MaterialColors.mainColor,
          ),
        ),
        child: FlatButton(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  (temp.contains("null")) ? 'Không chưa cập nhật' : temp,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              SizedBox(
                width: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
