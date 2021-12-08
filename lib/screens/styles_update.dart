import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pimo/constants/Images.dart';
import 'package:pimo/models/styles.dart';
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';
import 'package:pimo/screens/measure_template.dart';
import 'package:pimo/viewmodels/body_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:http/http.dart' as http;

class UpdateStylesProfilePage extends StatefulWidget {
  final int modelId;
  UpdateStylesProfilePage({Key key, this.modelId}) : super(key: key);
  @override
  _UpdateStylesProfilePage createState() => _UpdateStylesProfilePage();
}

class _UpdateStylesProfilePage extends State<UpdateStylesProfilePage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      fetchStyles();
    });
  }

  List list;
  // fetch
  List<Styles> parseStylesList(String responseBody) {
    int count = 0;
    var list = jsonDecode(responseBody);
    List<Styles> stylesListProject = new List<Styles>();
    list['styleList'].map((e) => count++).toList();
    for (int i = 0; i < count; i++) {
      stylesListProject.add(Styles.fromJson(list['styleList'][i]));
    }
    return stylesListProject;
  }

  bool isSexyChecked = false;
  bool isClassesChecked = false;
  bool isStreetChecked = false;
  bool isSummerChecked = false;
  bool isWinterChecked = false;
  bool isPositiveChecked = false;
  bool isNudeChecked = false;
  bool isArtChecked = false;

  Future<List> fetchStyles() async {
    final response =
        await http.get(Uri.parse(url + "api/v1/models/${widget.modelId}"));
    print(list);
    if (response.statusCode == 200) {
      list = parseStylesList(response.body);
      for (int i = 0; i < list.length; i++) {
        if (list[i].name == 'Gợi cảm') {
          isSexyChecked = true;
          selectedStyles.add(1);
        } else if (list[i].name == 'Cổ điển') {
          isClassesChecked = true;
          selectedStyles.add(2);
        } else if (list[i].name == 'Đường phố') {
          isStreetChecked = true;
          selectedStyles.add(3);
        } else if (list[i].name == 'Mùa hè') {
          isSummerChecked = true;
          selectedStyles.add(4);
        } else if (list[i].name == 'Mùa đông') {
          isWinterChecked = true;
          selectedStyles.add(5);
        } else if (list[i].name == 'Năng động') {
          isPositiveChecked = true;
          selectedStyles.add(6);
        } else if (list[i].name == 'Nude') {
          isNudeChecked = true;
          selectedStyles.add(7);
        } else if (list[i].name == 'Nghệ Thuật') {
          isArtChecked = true;
          selectedStyles.add(8);
        }
      }
    } else {
      throw Exception("Cannot fetch body ");
    }
  }

  // StyleChecked

  List<int> selectedStyles = List();

  updateModelDetail() async {
    var jwt = (await FlutterSession().get("jwt")).toString();
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
      'Authorization': 'Bearer ' + jwt,
    };
    var response = await http.put(
        Uri.parse('https://api.pimo.studio/api/v1/modelstyles'),
        headers: headers,
        body: jsonEncode(selectedStyles));

    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Cập nhật thành công');
      } else {
        throw Exception("Something wrong in update profile");
      }
    } on Exception catch (exception) {
      print("Exception: " + exception.toString());
    } catch (error) {
      print("ERROR: " + error.toString());
    }
  }

  Future<List> getAllStyles() async {
    final response =
        await http.get(Uri.parse('https://api.pimo.studio/api/v1/styles'));
    if (response.statusCode == 200) {
      var test = json.decode(response.body);
      return test["style"];
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: MaterialColors.mainColor,
              title: Text('Chỉnh sửa phong cách'),
            ),
            body: Wrap(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, width / 4, 0, 0),
                ),
                Column(
                  children: <Widget>[
                    FutureBuilder<List>(
                        future: getAllStyles(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List list1 = snapshot.data
                                .getRange(0, snapshot.data.length ~/ 2)
                                .toList();
                            List list2 = snapshot.data
                                .getRange(snapshot.data.length ~/ 2,
                                    snapshot.data.length)
                                .toList();
                            return Row(
                              children: <Widget>[
                                Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: list1.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => Row(
                                      children: [
                                        Checkbox(
                                          checkColor: Colors.white,
                                          fillColor:
                                              MaterialStateProperty.all<Color>(
                                                  MaterialColors.mainColor),
                                          value: index == 0
                                              ? isSexyChecked
                                              : (index == 1
                                                  ? isClassesChecked
                                                  : (index == 2
                                                      ? isStreetChecked
                                                      : isSummerChecked)),
                                          onChanged: (bool value) {
                                            setState(() {
                                              if (list1[index]["name"] ==
                                                  "Gợi cảm") {
                                                isSexyChecked = value;
                                                if (value == true) {
                                                  selectedStyles.add(index + 1);
                                                } else {
                                                  selectedStyles
                                                      .remove(index + 1);
                                                }
                                              } else if (list1[index]["name"] ==
                                                  "Cổ điển") {
                                                isClassesChecked = value;
                                                if (value == true) {
                                                  selectedStyles.add(index + 1);
                                                } else {
                                                  selectedStyles
                                                      .remove(index + 1);
                                                }
                                              } else if (list1[index]["name"] ==
                                                  "Đường phố") {
                                                isStreetChecked = value;
                                                if (value == true) {
                                                  selectedStyles.add(index + 1);
                                                } else {
                                                  selectedStyles
                                                      .remove(index + 1);
                                                }
                                              } else {
                                                isSummerChecked = value;
                                                if (value == true) {
                                                  selectedStyles.add(index + 1);
                                                } else {
                                                  selectedStyles
                                                      .remove(index + 1);
                                                }
                                              }
                                              print(selectedStyles);
                                            });
                                          },
                                        ),
                                        Text(list1[index]["name"])
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: list2.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => Row(
                                      children: [
                                        Checkbox(
                                          checkColor: Colors.white,
                                          fillColor:
                                              MaterialStateProperty.all<Color>(
                                                  MaterialColors.mainColor),
                                          value: index == 0
                                              ? isWinterChecked
                                              : (index == 1
                                                  ? isPositiveChecked
                                                  : (index == 2
                                                      ? isNudeChecked
                                                      : isArtChecked)),
                                          onChanged: (bool value) {
                                            setState(() {
                                              if (list2[index]["name"] ==
                                                  "Mùa đông") {
                                                isWinterChecked = value;
                                                if (value == true) {
                                                  selectedStyles.add(index + 5);
                                                } else {
                                                  selectedStyles
                                                      .remove(index + 5);
                                                }
                                              } else if (list2[index]["name"] ==
                                                  "Năng động") {
                                                isPositiveChecked = value;
                                                if (value == true) {
                                                  selectedStyles.add(index + 5);
                                                } else {
                                                  selectedStyles
                                                      .remove(index + 5);
                                                }
                                              } else if (list2[index]["name"] ==
                                                  "Nude") {
                                                isNudeChecked = value;
                                                if (value == true) {
                                                  selectedStyles.add(index + 5);
                                                } else {
                                                  selectedStyles
                                                      .remove(index + 5);
                                                }
                                              } else {
                                                isArtChecked = value;
                                                if (value == true) {
                                                  selectedStyles.add(index + 5);
                                                } else {
                                                  selectedStyles
                                                      .remove(index + 5);
                                                }
                                              }
                                            });
                                          },
                                        ),
                                        Text(list2[index]["name"])
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        })
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(120),
                  child: ElevatedButton(
                    child:
                        Text('Cập nhật', style: TextStyle(color: Colors.black)),
                    onPressed: () async {
                      updateModelDetail();
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MultiProvider(
                                    providers: [
                                      ChangeNotifierProvider(
                                        create: (_) => BodyPartListViewModel(),
                                      ),
                                    ],
                                    child: FutureBuilder(
                                      builder: (context, snapshot) {
                                        return MeasureTemplatePage(
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
                )
              ],
            )));
  }
}
