//import 'dart:js';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/models/project.dart';
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';
import 'package:pimo/viewmodels/collection_bodypart_list_view_model.dart';
import 'package:pimo/viewmodels/collection_bodypart_view_model.dart';
import 'package:pimo/viewmodels/image_collection_bodypart_list_view_model.dart';
import 'package:pimo/viewmodels/image_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'image_in_collection_bodypart.dart';

class ModelCollectionBodyPart extends StatefulWidget {
  const ModelCollectionBodyPart({Key key}) : super(key: key);

  @override
  _ModelBodyPartProjectState createState() => _ModelBodyPartProjectState();
}

class _ModelBodyPartProjectState extends State<ModelCollectionBodyPart>
    with ChangeNotifier {
  @override
  void initState() {
    super.initState();
  }

  Future<List> fetchProject(String modelId) async {
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
  Widget build(BuildContext context) {
    //Lựa chọn bộ sưu tập của người mẫu.
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
                  title: const Text('Bộ sưu tập cá nhân'),
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
                            child: FutureBuilder<
                                ListCollectionBodyPartListViewModel>(
                              future: Provider.of<
                                          ListCollectionBodyPartListViewModel>(
                                      context,
                                      listen: false)
                                  .getListCollectionBodyPart(
                                      snapshot.data.toString()),
                              builder: (context, data) {
                                if (data.connectionState ==
                                    ConnectionState.waiting) {
                                  return Column(
                                    children: const <Widget>[
                                      SizedBox(
                                        height: 150,
                                      ),
                                      Center(
                                          child: CircularProgressIndicator()),
                                    ],
                                  );
                                } else {
                                  if (data.error == null) {
                                    return Consumer<
                                        ListCollectionBodyPartListViewModel>(
                                      builder: (ctx, data, child) =>
                                          ListView.builder(
                                        itemCount:
                                            data.listCollectionBodyPart.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return _buildImageCollectList(
                                              (context),
                                              data.listCollectionBodyPart[
                                                  index],
                                              index,
                                              snapshot.data.toString());
                                        },
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                      child:
                                          Text('Hiện tại chưa có bộ sưu tập'),
                                    );
                                  }
                                }
                              },
                            )),
                      )
                    ],
                  ),
                ),
              );
            }));
  }

  Widget _buildImageCollectList(
      BuildContext context, CollectionBodyPartViewModel collection, int index, String modelId) {
    // Size size = MediaQuery.of(context).size;
    // deleteCollectionBodyPart(String name, String description) async {
    //   String id = (await FlutterSession().get('modelId')).toString();
    //   String accessToken = (await FlutterSession().get('jwt')).toString();
    //   var bodyPartId = 0;
    //   var headers = {
    //     'Content-Type': 'application/json;charset=UTF-8',
    //     "Access-Control-Allow-Origin": "*",
    //     'Authorization': 'Bearer ' + accessToken
    //   };
    //   var msg = "Tạo thất bại";
    //   final bodypart = await http.get(
    //     Uri.parse(
    //         'https://api.pimo.studio/api/v1/bodyparts?modelId=$id&bodyPartTypeId=22'),
    //     headers: headers,
    //   );
    //   if (bodypart.statusCode == 200) {
    //     bodyPartId = (jsonDecode(bodypart.body)["bodyPart"]["id"]);
    //     var response = await http.post(
    //         Uri.parse('https://api.pimo.studio/api/v1/collectionbodyparts'),
    //         headers: headers,
    //         body: jsonEncode({
    //           "name": name,
    //           "description": description,
    //           "bodyPartId": bodyPartId
    //         }));

    //     if (response.statusCode == 200) {
    //       var body = jsonDecode(response.body);
    //       if (body["success"]) {
    //         msg = "Tạo thành công";
    //         _reloadPage();
    //       }
    //     } else {
    //       msg = "Tạo thất bại";
    //       //throw Exception('Failed');
    //     }
    //   }

    //   return Fluttertoast.showToast(
    //       msg: msg,
    //       toastLength: Toast.LENGTH_LONG,
    //       gravity: ToastGravity.BOTTOM);
    // }
    Future _showDeleteDialog(BuildContext context, int id) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Bạn muốn xóa?",
                style: TextStyle(color: Colors.black),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Hủy',
                    style: TextStyle(color: Colors.grey),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 0,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // await ImageCollectionService().deleteCollection(id);
                    // Navigator.of(context).pop();
                    // await _reloadPage();
                  },
                  child: const Text(
                    'Xóa',
                    style: TextStyle(color: MaterialColors.mainColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 0,
                  ),
                ),
              ],
            );
          });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(-2, 5),
              blurRadius: 10,
              color: MaterialColors.mainColor.withOpacity(0.5),
            )
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: MaterialColors.mainColor,
            // width: 2,
          ),
        ),
        child: FlatButton(
          padding: const EdgeInsets.only(left: 30, top: 15, bottom: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.white,
          onLongPress: () async {
            await _showDeleteDialog(context, collection.idCollection);
          },
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                                create: (_) => ImageListViewModel()),
                          ],
                          child: FutureBuilder(
                            builder: (context, snapshot) {
                              //Chọn 1 bộ sưu tập, sau đó xuất hiện hình ảnh ở đây!
                              //Gia tri collection ID dung.
                              return ImageInCollectionBodyPartPage(
                                collection: collection,
                                modelId: modelId,
                                index: index,
                              );
                            },
                          ))),
            );
          },
          child: Row(
            children: [
              Expanded(
                child: Text(
                  collection.nameCollection,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const Icon(
                Icons.navigate_next,
              ),
              const SizedBox(
                width: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _reloadPage() async {
    Navigator.pushReplacement(
      this.context,
      MaterialPageRoute(
          builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                        create: (_) => ImageCollectionBodyPartListViewModel()),
                  ],
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      return const ModelCollectionBodyPart();
                    },
                  ))),
    );
  }

  void _showDialog(BuildContext context, String modelId) async {
    // Future<List<Project>> fetchProject(String modelId) async {
    //   final response = await http.get(
    //       Uri.parse('https://api.pimo.studio/api/v1/projects/model/$modelId'));
    //   if (response.statusCode == 200) {
    //     var listProject = json.decode(response.body);
    //     var list = listProject["product"];
    //     List<Project> projectList = List<Project>.from(
    //         list.map((project) => Project.fromJson(project)));
    //     return projectList;
    //   } else {
    //     throw Exception('Failed to load album');
    //   }
    // }

    addCollectionBodyPart(String name, String description) async {
      String id = (await FlutterSession().get('modelId')).toString();
      String accessToken = (await FlutterSession().get('jwt')).toString();
      var bodyPartId = 0;
      var headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
        'Authorization': 'Bearer ' + accessToken
      };
      var msg = "Tạo thất bại";
      final bodypart = await http.get(
        Uri.parse(
            'https://api.pimo.studio/api/v1/bodyparts?modelId=$id&bodyPartTypeId=22'),
        headers: headers,
      );
      if (bodypart.statusCode == 200) {
        bodyPartId = (jsonDecode(bodypart.body)["bodyPart"]["id"]);
        var response = await http.post(
            Uri.parse('https://api.pimo.studio/api/v1/collectionbodyparts'),
            headers: headers,
            body: jsonEncode({
              "name": name,
              "description": description,
              "bodyPartId": bodyPartId
            }));

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
    Project selectProject;
    int projectId = 0;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Tạo bộ sưu tập"),
          content: Builder(
            builder: (context) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 150,
                width: 300,
                child: ListView(
                  children: [
                    // Row(
                    //   children: <Widget>[
                    //     FutureBuilder(
                    //       future: fetchProject(modelId),
                    //       builder: (context, snapshot) {
                    //         return DropdownButton<Project>(
                    //           hint: const Text("Chọn dự án của bạn"),
                    //           value: selectProject,
                    //           onChanged: (Project newValue) {
                    //             setState(() {
                    //               selectProject = newValue;
                    //               projectId = newValue.id;
                    //             });
                    //           },
                    //           items: snapshot.data
                    //               .map<DropdownMenuItem<Project>>(
                    //                   (Project user) {
                    //             return DropdownMenuItem<Project>(
                    //               value: user,
                    //               child: Text(
                    //                 user.name,
                    //                 style: const TextStyle(color: Colors.black),
                    //               ),
                    //             );
                    //           }).toList(),
                    //         );
                    //       },
                    //     ),
                    //   ],
                    // ),
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
                print(nameController.text);
                // if (nameController.text.isNotEmpty) {
                //   await ImageCollectionBodyPartService()
                //       .createCollection(nameController.text);
                //   Navigator.of(context).pop();
                //   await _reloadPage();
                // } else {
                //   Fluttertoast.showToast(msg: 'Tên không được để trống');
                // }
                await addCollectionBodyPart(
                    nameController.text, desController.text);
              },
            ),
          ],
        );
      },
    );
  }
}
