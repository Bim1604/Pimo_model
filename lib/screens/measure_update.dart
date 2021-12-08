import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pimo/constants/Images.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/models/body.dart';
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';
import 'package:pimo/screens/measure_template.dart';
import 'package:pimo/viewmodels/body_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UpdateMeasureProfilePage extends StatefulWidget {
  final int modelId;
  UpdateMeasureProfilePage({Key key, this.modelId}) : super(key: key);
  @override
  _UpdateMeasureProfilePage createState() => _UpdateMeasureProfilePage();
}

class _UpdateMeasureProfilePage extends State<UpdateMeasureProfilePage> {
  @override
  void initState() {
    super.initState();
    fetchCasting();
  }

  String heigh = "";
  String weight = "";
  String chest = "";
  String waist = "";
  String butt = "";
  String tatto = "";

  TextEditingController heightController,
      weightController,
      chestController,
      waistController,
      buttController,
      tattoController;
  List list;

  List<BodyPart> parseBodyPartList(String responseBody) {
    int count = 0;
    var list = jsonDecode(responseBody);
    List<BodyPart> collectionListProject = new List<BodyPart>();
    list['listBodyPart'].map((e) => count++).toList();
    for (int i = 0; i < count; i++) {
      collectionListProject.add(BodyPart.fromJson(list['listBodyPart'][i]));
    }
    return collectionListProject;
  }

  Future<List> fetchCasting() async {
    final response =
        await http.get(Uri.parse(url + "api/v1/models/${widget.modelId}"));
    if (response.statusCode == 200) {
      list = parseBodyPartList(response.body);
      heightController = TextEditingController()
        ..text = list[0].value.quantityValue.toString();
      weightController = TextEditingController()
        ..text = list[1].value.quantityValue.toString();
      chestController = TextEditingController()
        ..text = list[2].value.quantityValue.toString();
      waistController = TextEditingController()
        ..text = list[3].value.quantityValue.toString();
      buttController = TextEditingController()
        ..text = list[4].value.quantityValue.toString();
      tattoController = TextEditingController()
        ..text = list[5].value.quantityValue.toString();
    } else {
      throw Exception("Cannot fetch body ");
    }
  }

  updateMeasureDetail() async {
    var jwt = (await FlutterSession().get("jwt")).toString();
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
      'Authorization': 'Bearer ' + jwt,
    };
    var response = await http.put(
        Uri.parse('https://api.pimo.studio/api/v1/bodyparts/measure'),
        headers: headers,
        body: jsonEncode({
          "height": double.tryParse(heightController.text).toInt(),
          "weight": double.tryParse(weightController.text).toInt(),
          "bust": double.tryParse(chestController.text).toInt(),
          "hip": double.tryParse(waistController.text).toInt(),
          "waist": double.tryParse(buttController.text).toInt(),
        }));
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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Chỉnh sửa thông tin',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: SizedBox(
                    height: height / 1.4,
                    child: FutureBuilder<BodyPartListViewModel>(
                      future: Provider.of<BodyPartListViewModel>(context,
                              listen: false)
                          .getListBodyPart(widget.modelId),
                      builder: (ctx, prevData) {
                        if (prevData.connectionState ==
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
                          if (prevData.error == null) {
                            return Consumer<BodyPartListViewModel>(
                              builder: (ctx, data, child) => Form(
                                child: Column(
                                  children: [
                                    Container(
                                      child: ListView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        padding: EdgeInsets.all(30),
                                        children: [
                                          TextFormField(
                                            controller: heightController,
                                            onChanged: (text) {
                                              heigh = text;
                                            },
                                            cursorColor:
                                                MaterialColors.mainColor,
                                            decoration: InputDecoration(
                                              labelText: data
                                                      .listBodyPart[0].name +
                                                  '(' +
                                                  data.listBodyPart[0].measure +
                                                  ')',
                                            ),
                                          ),
                                          TextFormField(
                                            controller: weightController,
                                            cursorColor:
                                                MaterialColors.mainColor,
                                            onChanged: (text) {
                                              weight = text;
                                            },
                                            decoration: InputDecoration(
                                              labelText: data
                                                      .listBodyPart[1].name +
                                                  '(' +
                                                  data.listBodyPart[1].measure +
                                                  ')',
                                            ),
                                          ),
                                          TextFormField(
                                            controller: chestController,
                                            onChanged: (text) {
                                              chest = text;
                                            },
                                            cursorColor:
                                                MaterialColors.mainColor,
                                            decoration: InputDecoration(
                                              labelText: data
                                                      .listBodyPart[2].name +
                                                  '(' +
                                                  data.listBodyPart[2].measure +
                                                  ')',
                                            ),
                                          ),
                                          TextFormField(
                                            controller: waistController,
                                            onChanged: (text) {
                                              waist = text;
                                            },
                                            cursorColor:
                                                MaterialColors.mainColor,
                                            decoration: InputDecoration(
                                              labelText: data
                                                      .listBodyPart[3].name +
                                                  '(' +
                                                  data.listBodyPart[3].measure +
                                                  ')',
                                            ),
                                          ),
                                          TextFormField(
                                            controller: buttController,
                                            onChanged: (text) {
                                              butt = text;
                                            },
                                            cursorColor:
                                                MaterialColors.mainColor,
                                            decoration: InputDecoration(
                                              labelText: data
                                                      .listBodyPart[4].name +
                                                  '(' +
                                                  data.listBodyPart[4].measure +
                                                  ')',
                                            ),
                                          ),
                                          TextFormField(
                                            controller: tattoController,
                                            onChanged: (text) {
                                              tatto = text;
                                            },
                                            cursorColor:
                                                MaterialColors.mainColor,
                                            decoration: InputDecoration(
                                              labelText: data
                                                      .listBodyPart[5].name +
                                                  '(' +
                                                  data.listBodyPart[5].measure +
                                                  ')',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Text('Lỗi');
                          }
                        }
                      },
                    )),
              ),
              ElevatedButton(
                child: Text('Cập nhật', style: TextStyle(color: Colors.black)),
                onPressed: () async {
                  updateMeasureDetail();
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
            ],
          ),
        ),
      ),
    );
  }
}
