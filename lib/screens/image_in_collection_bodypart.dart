import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';
import 'package:pimo/viewmodels/collection_bodypart_list_view_model.dart';
import 'package:pimo/viewmodels/collection_bodypart_view_model.dart';
import 'package:pimo/viewmodels/image_list_view_model.dart';
import 'package:pimo/viewmodels/model_image_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'intro_image_body_part.dart';
import 'package:http_parser/http_parser.dart';

class ImageInCollectionBodyPartPage extends StatefulWidget {
  final CollectionBodyPartViewModel collection;
  final int index;
  final String modelId;
  const ImageInCollectionBodyPartPage(
      {Key key, this.collection, this.index, this.modelId})
      : super(key: key);

  @override
  _ImageInCollectionPageState createState() => _ImageInCollectionPageState();
}

class _ImageInCollectionPageState extends State<ImageInCollectionBodyPartPage> {
  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  bool isLoading = false;
  PickedFile imageFile;

  addImageBodyPart(int collectionId, PickedFile imageFile) async {
    var jwt = (await FlutterSession().get("jwt")).toString();
    var dio = Dio();
    String fileName = imageFile.path.split('/').last;
    FormData formData = FormData.fromMap({
      "collectionId": collectionId,
      "fileImage": await MultipartFile.fromFile(imageFile.path,
          filename: fileName, contentType: MediaType("image", "jpeg")),
    });
    var response = await dio.post(
      ("https://api.pimo.studio/api/v1/imagebodyparts"),
      options: Options(headers: {
        'Content-Type': "multipart/form-data",
        "Authorization": 'Bearer $jwt',
      }),
      data: formData,
    );
    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Th??m th??nh c??ng');
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
    addImageBodyPart(widget.collection.idCollection, imageFile);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("H??nh ???nh"),
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
                    .getImageListBodyPart(widget.collection.idCollection,
                        widget.index, widget.modelId),
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
                        builder: (ctx, data, child) =>
                            StaggeredGridView.countBuilder(
                                crossAxisCount: 2,
                                itemCount: data.images.length,
                                itemBuilder: (context, index) {
                                  return _buildImageList(
                                      (context),
                                      data.images[index],
                                      index,
                                      widget.collection.idCollection);
                                },
                                staggeredTileBuilder: (index) {
                                  return StaggeredTile.count(
                                      1, index.isEven ? 1.2 : 2);
                                }),
                      );
                    } else {
                      return const Center(
                        child: Text('Kh??ng c?? h??nh ???nh'),
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

  Widget _buildImageList(BuildContext context, ModelImageViewModel image,
      int index, int collectionId) {
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
                            return IntroImageBodyPartPage(
                              beginIndex: index,
                              collectionId: widget.collection.idCollection,
                              modelId: widget.modelId,
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
                        create: (_) => ListCollectionBodyPartListViewModel()),
                  ],
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      return ImageInCollectionBodyPartPage(
                        collection: widget.collection,
                      );
                    },
                  ))),
    );
  }
}
