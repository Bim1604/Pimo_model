import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pimo/animations/page_transformer.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';
import 'package:pimo/viewmodels/image_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'image_item.dart';

class IntroImageBodyPartPage extends StatefulWidget {
  final int beginIndex;
  final int collectionId;
  final String modelId;
  final int imageId;
  const IntroImageBodyPartPage(
      {Key key, this.collectionId, this.beginIndex, this.modelId, this.imageId})
      : super(key: key);

  @override
  _IntroImageBodyPartPageState createState() => _IntroImageBodyPartPageState();
}

class _IntroImageBodyPartPageState extends State<IntroImageBodyPartPage> {
  @override
  void initState() {
    super.initState();
  }

  deleteImageBodyPart(int imageId) async {
    String accessToken = (await FlutterSession().get('jwt')).toString();
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
      'Authorization': 'Bearer ' + accessToken
    };
    var msg = "Xoá thất bại";
    var response = await http.delete(
        Uri.parse('https://api.pimo.studio/api/v1/imagebodyparts'),
        headers: headers,
        body: jsonEncode(imageId));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (body["success"]) {
        msg = "Đã xoá";
        //_reloadPage();
      }
    } else {
      msg = "Xoá thất bại";
      //throw Exception('Failed');
    }

    return Fluttertoast.showToast(
        msg: msg, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
  }

  Future _showDialog(BuildContext context, int imageId) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Bạn chắc chắn muốn xóa?",
                style: TextStyle(color: MaterialColors.mainColor),
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
                    await deleteImageBodyPart(imageId);
                    Navigator.pop(context);
                    // await ImageService().deleteImage(image.fileName, image.id);
                    // Navigator.of(context).pop();
                    // _reloadPage();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết hình ảnh'),
        backgroundColor: MaterialColors.mainColor,
        actions: [
          IconButton(onPressed: () {
            _showDialog(context, int.tryParse(widget.modelId));
          }, icon: const Icon(Icons.delete_forever_outlined))
        ],
      ),
      body: Center(
        child: SizedBox.fromSize(
            size: const Size.fromHeight(500.0),
            child: FutureBuilder<ImageListViewModel>(
              future: Provider.of<ImageListViewModel>(context, listen: false)
                  .getImageListBodyPart(
                      widget.collectionId, widget.beginIndex, widget.modelId),
              builder: (context, data) {
                if (data.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: const <Widget>[
                      SizedBox(
                        height: 150,
                      ),
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                } else {
                  if (data.error == null) {
                    return Consumer<ImageListViewModel>(
                        builder: (ctx, data, child) => PageTransformer(
                              pageViewBuilder: (context, visibilityResolver) {
                                return PageView.builder(
                                  controller: PageController(
                                      initialPage: widget.beginIndex,
                                      keepPage: true,
                                      viewportFraction: 1),
                                  itemCount: data.images.length,
                                  itemBuilder: (context, index) {
                                    var item = data.images.elementAt(index);
                                    var pageVisibility = visibilityResolver
                                        .resolvePageVisibility(index);
                                    return ImageItemPage(
                                      item: item,
                                      pageVisibility: pageVisibility,
                                    );
                                  },
                                );
                              },
                            ));
                  } else {
                    return Text('Error');
                  }
                }
              },
            )),
      ),
    );
  }
}
