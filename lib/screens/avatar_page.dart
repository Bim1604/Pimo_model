import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'model_profile.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class CameraWidget extends StatefulWidget {
  final int modelId;
  const CameraWidget({Key key, this.modelId}) : super(key: key);

  @override
  State createState() {
    return CameraWidgetState();
  }
}

class CameraWidgetState extends State<CameraWidget> {
  @override
  void initState() {
    super.initState();
    // PushNotificationService().init(context);
  }

  uploadAvatar() async {
    String id = (await FlutterSession().get("modelId")).toString();
    var jwt = (await FlutterSession().get("jwt")).toString();
    final response =
        await http.get(Uri.parse('https://api.pimo.studio/api/v1/models/$id'));
    if (response.statusCode == 200) {
      var model = json.decode(response.body);
      String fileName = imageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        "name": model["model"][0]["model"]["name"],
        "genderId": model["model"][0]["model"]["genderId"],
        "dateOfBirth": model["model"][0]["model"]["dateOfBirth"],
        "country": model["model"][0]["model"]["country"],
        "province": model["model"][0]["model"]["province"],
        "district": model["model"][0]["model"]["district"],
        "phone": model["model"][0]["model"]["phone"],
        "mail": model["model"][0]["model"]["mail"],
        "status": model["model"][0]["model"]["status"],
        "gifted": model["model"][0]["model"]["gifted"],
        "description": model["model"][0]["model"]["description"],
        "instagram": model["model"][0]["model"]["instagram"],
        "twitter": model["model"][0]["model"]["twitter"],
        "facebook": model["model"][0]["model"]["facebook"],
        "LinkAvatar": "",
        "imageAvatar": await MultipartFile.fromFile(imageFile.path,
            filename: fileName, contentType: MediaType("image", "jpeg")),
      });
      var dio = Dio();
      var upload = await dio.put(
        ("https://api.pimo.studio/api/v1/models"),
        options: Options(headers: {
          'Content-Type': "multipart/form-data",
          "Authorization": 'Bearer $jwt',
        }),
        data: formData,
      );
      try {
        if (upload.statusCode == 200) {
          Fluttertoast.showToast(msg: 'Thêm thành công');
          Future.delayed(const Duration(milliseconds: 5000), () {
            Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => ModelProfilePage(),
                ));
          });
        } else {
          throw Exception("Something wrong in update profile");
        }
      } on Exception catch (exception) {
        print("Exception: " + exception.toString());
      } catch (error) {
        print("ERROR: " + error.toString());
      }
    } else {
      throw Exception('Failed to load album');
    }
  }

  PickedFile imageFile;

  Future _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Lựa chọn",
              style: TextStyle(color: MaterialColors.mainColor),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 2,
                    color: MaterialColors.mainColor,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Ảnh"),
                    leading: Icon(
                      Icons.image,
                      color: MaterialColors.mainColor,
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: MaterialColors.mainColor,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: MaterialColors.mainColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thay avatar"),
        backgroundColor: MaterialColors.mainColor,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => {_showChoiceDialog(context)},
                child: Container(
                  width: 320,
                  height: 320,
                  decoration: BoxDecoration(
                      color: MaterialColors.mainColor,
                      borderRadius: BorderRadius.all(Radius.circular(160)),
                      border: Border.all(
                        color: MaterialColors.mainColor,
                      )),
                  child: (imageFile == null)
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "Chọn ảnh",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: FileImage(File(imageFile.path)),
                                fit: BoxFit.cover),
                          ),
                        ),
                ),
              ),
              RaisedButton(
                onPressed: () async {
                  if (imageFile != null) {
                    uploadAvatar();
                  }
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => MainScreen(),
                  //     ));
                },
                color: MaterialColors.mainColor,
                child: const Text(
                  "Cập nhật",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.pop(context);
  }
}
