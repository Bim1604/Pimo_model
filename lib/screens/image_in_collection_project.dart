
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';
import 'package:pimo/screens/intro_image_project.dart';
import 'package:pimo/viewmodels/collection_project_list_view_model.dart';
import 'package:pimo/viewmodels/collection_project_view_model.dart';
import 'package:pimo/viewmodels/image_list_view_model.dart';
import 'package:pimo/viewmodels/model_image_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:http_parser/http_parser.dart';

class ImageInCollectionProjectPage extends StatefulWidget {
  final CollectionProjectViewModel collection;
  final int index;
  final String modelId;
  const ImageInCollectionProjectPage(
      {Key key, this.collection, this.index, this.modelId})
      : super(key: key);

  @override
  _ImageInCollectionPageState createState() => _ImageInCollectionPageState();
}

class _ImageInCollectionPageState extends State<ImageInCollectionProjectPage> {
  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  bool isLoading = false;
  PickedFile imageFile;

  addImageProject(int collectionId, PickedFile imageFile) async {
    print(collectionId);
    var jwt = (await FlutterSession().get("jwt")).toString();
    var dio = Dio();
    String fileName = imageFile.path.split('/').last;
    FormData formData = FormData.fromMap({
      "collectionId": collectionId,
      "fileImage": await MultipartFile.fromFile(imageFile.path,
          filename: fileName, contentType: MediaType("image", "jpeg")),
    });
    var response = await dio.post(
      ("https://api.pimo.studio/api/v1/imageprojects"),
      options: Options(headers: {
        'Content-Type': "multipart/form-data",
        "Authorization": 'Bearer $jwt',
      }),
      data: formData,
    );
    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Thêm thành công');
      } else {
        throw Exception("Something wrong in update profile");
      }
    } on Exception catch (exception) {
      print("Exception: " + exception.toString());
    } catch (error) {
      print("ERROR: " + error.toString());
    }
  }

  

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile;
    });
    addImageProject(widget.collection.idCollection, imageFile);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Hình ảnh"),
          backgroundColor: MaterialColors.mainColor,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: MaterialColors.mainColor,
          onPressed: () async => {
            _openGallery(context),
            // await ImageService().uploadImage(widget.collection.id),
            // _reloadPage()
          },
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: FutureBuilder<ImageListViewModel>(
                future: Provider.of<ImageListViewModel>(context, listen: false)
                    .getImageListProject(widget.collection.idCollection,
                        widget.index, widget.modelId),
                builder: (context, data) {
                  print(data.data);
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
                        builder: (ctx, data, child) =>
                            StaggeredGridView.countBuilder(
                                crossAxisCount: 2,
                                itemCount: data.images.length,
                                itemBuilder: (context, index) {
                                  return _buildImageList(
                                      (context), data.images[index], index, widget.collection.idCollection);
                                },
                                staggeredTileBuilder: (index) {
                                  return StaggeredTile.count(
                                      1, index.isEven ? 1.2 : 2);
                                }),
                      );
                    } else {
                      return const Center(
                        child: Text('Không có hình ảnh'),
                      );
                    }
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageList(
      BuildContext context, ModelImageViewModel image, int index, int collectionId) {
    bool isSelect = false;

    return GestureDetector(
        // onLongPress: () => {
        //       _showDialog(context, image.id),
        //     },
        onTap: () {
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
                            return IntroImageProjectPage(
                              beginIndex: index,
                              collectionId: widget.collection.idCollection,
                              modelId: widget.modelId
                            );
                          },
                        ))),
          );
        },
        child: (!isSelect)
            ? Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-2, 5),
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.3),
                      )
                    ],
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(
                          image.fileName,
                        ),
                        fit: BoxFit.cover)),
              )
            : Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-2, 5),
                      blurRadius: 10,
                      color: MaterialColors.mainColor.withOpacity(0.3),
                    )
                  ],
                  color: MaterialColors.mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ));
  }

  Future _reloadPage() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                        create: (_) => ListCollectionProjectListViewModel()),
                  ],
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      return ImageInCollectionProjectPage(
                        collection: widget.collection,
                      );
                    },
                  ))),
    );
  }
}
