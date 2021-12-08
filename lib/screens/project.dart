import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pimo/constants/Images.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/models/brand.dart';
import 'package:pimo/models/project.dart';
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';
import 'package:pimo/viewmodels/model_view_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ProjectPage extends StatefulWidget {
  const ProjectPage();

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  String genderController;
  TextEditingController nameController,
      dobController,
      phoneController,
      countryController,
      provinceController,
      districtController,
      descriptionController,
      giftedController;

  GlobalKey<FormState> _profileKey = GlobalKey<FormState>();

  Future<List> fetchProject() async {
    String modelId = (await FlutterSession().get("modelId")).toString();
    final response = await http.get(
        Uri.parse('https://api.pimo.studio/api/v1/projects/model/$modelId'));
    if (response.statusCode == 200) {
      var listProject = json.decode(response.body);
      return listProject["product"];
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    super.dispose();
  }

  String formatDate(String date) {
    DateTime dt = DateTime.parse(date);
    // var formatter = new DateFormat('EEEE, dd MMM, yyyy');
    var formatter = new DateFormat('dd MMM, yyyy');
    return formatter.format(dt);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder(
            future: FlutterSession().get("modelId"),
            builder: (context, snapshot) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.add),
                  backgroundColor: MaterialColors.mainColor,
                  onPressed: () async =>
                      {_showDialog(context, snapshot.data.toString())},
                ),
                appBar: AppBar(
                  title: const Text('Dự án của bạn'),
                  backgroundColor: MaterialColors.mainColor,
                ),
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              //Sửa từ trên xuống
                              child: FutureBuilder<List>(
                                future: fetchProject(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    List list = snapshot.data;
                                    return ListView.builder(
                                      itemCount: list.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40, vertical: 5),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: Offset(-2, 5),
                                                  blurRadius: 10,
                                                  color: MaterialColors
                                                      .mainColor
                                                      .withOpacity(0.5),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: MaterialColors.mainColor,
                                              ),
                                            ),
                                            child: FlatButton(
                                              onPressed: (){},
                                              padding: const EdgeInsets.only(
                                                  left: 30,
                                                  top: 15,
                                                  bottom: 15),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              color: Colors.white,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      list[index]["name"],
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return const Center(child: Text("Đang tải"));
                                  }
                                },
                              ))),
                    ],
                  ),
                ),
              );
            }));
  }

  void _showDialog(BuildContext context, String modelId) async {
    Future<List<Brand>> fetchBrand() async {
      final response = await http.get(
          Uri.parse('https://api.pimo.studio/api/v1/brands'));
      if (response.statusCode == 200) {
        var listProject = json.decode(response.body);
        var list = listProject["brandList"];
        List<Brand> listBrand = new List<Brand>();
        for (var i = 0; i < list.length; i++) {
          var brand = Brand.fromJson(list[i]["brand"]);
          listBrand.add(brand);
        }
        return listBrand;
      } else {
        throw Exception('Failed to load album');
      }
    }

    addProject(String name, String description, int brandId) async {
      String id = (await FlutterSession().get('modelId')).toString();
      String accessToken = (await FlutterSession().get('jwt')).toString();
      var headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer ' + accessToken
      };
      print(brandId);
      var msg = "Tạo thất bại";
      var response = await http.post(
          Uri.parse('https://api.pimo.studio/api/v1/projects'),
          headers: headers,
          body: jsonEncode({
            "name": name,
            "description": description,
            "brandId": brandId,
            "modelId": id
          }));
        print(response.body);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        if (body["success"]) {
          msg = "Tạo thành công";
          //_reloadPage();
        }
      } else {
        msg = "Tạo thất bại";
        //throw Exception('Failed');
      }

      return Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
    }

    TextEditingController nameController;
    nameController = TextEditingController()..text = '';
    TextEditingController desController;
    desController = TextEditingController()..text = '';
    Brand selectProject;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Tạo bộ sưu tập"),
          content: Builder(
            builder: (context) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 300,
                width: 300,
                child: ListView(
                  children: [
                    Row(
                      children: <Widget>[
                        FutureBuilder(
                          future: fetchBrand(),
                          builder: (context, snapshot) {
                            print(snapshot.data);
                            return DropdownButton<Brand>(
                              hint: const Text("Chọn nhãn hàng"),
                              value: selectProject,
                              onChanged: (Brand newValue) {
                                setState(() {
                                  selectProject = newValue;
                                });
                                
                              },
                              items: snapshot.data
                                  .map<DropdownMenuItem<Brand>>(
                                      (Brand user) {
                                return DropdownMenuItem<Brand>(
                                  value: user,
                                  child: Text(
                                    user.name,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        cursorColor: MaterialColors.mainColor,
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "Tên",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        cursorColor: MaterialColors.mainColor,
                        controller: desController,
                        decoration: const InputDecoration(
                          labelText: "Mô tả",
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text(
                'Hủy',
                style: TextStyle(color: Colors.grey),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                elevation: 0,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text(
                'Tạo',
                style: TextStyle(color: MaterialColors.mainColor),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                elevation: 0,
              ),
              onPressed: () async {
                await addProject(
                    nameController.text, desController.text, selectProject.id);
              },
            ),
          ],
        );
      },
    );
  }
}
