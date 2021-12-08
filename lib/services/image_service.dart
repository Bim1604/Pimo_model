import 'dart:convert';
import 'dart:io';

import 'package:pimo/constants/Images.dart';
import 'package:pimo/models/collection_bodypart.dart';
import 'package:pimo/models/collection_project.dart';
import 'package:pimo/models/image.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';


Future<String> uploadFireBase(String path, int modelId) async {
  var token = (await FlutterSession().get("jwt")).toString();
  Map<String, String> heads = Map<String, String>();
  heads['Content-Type'] = 'application/json';
  heads['Accept'] = 'application/json';
  heads['Authorization'] = 'Bearer $token';
  final _firebaseStorage = FirebaseStorage.instance;

  var file = File(path);

  var snapshot = await _firebaseStorage
      .ref()
      .child('models/' + '$modelId' + "/avatar/images.jpg")
      .putFile(file);
  var downloadUrl = await snapshot.ref.getDownloadURL();

  Map<String, dynamic> params = Map<String, dynamic>();
  params['id'] = modelId;
  params['avatar'] = downloadUrl;

  final message = jsonEncode(params);
  final response = await http.put(
      Uri.parse(url + 'api/v1/models/${params["id"]}/avatar'),
      body: message,
      headers: heads);
  if (response.statusCode == 200) {
    return downloadUrl;
  } else {
    throw Exception('Failed to load');
  }
}

class ImageService {

  List<ModelImage> parseImageListProject(String responseBody, int index) {
    int count = 0;
    var list = jsonDecode(responseBody);
    List<ModelImage> imageList = new List<ModelImage>();
    List<ListCollectionProject> collectionListProject = new List<ListCollectionProject>();
    list['listCollectionProject'].map((e) => count++).toList();
    for (int i = 0; i < count; i++) {
      collectionListProject.add(ListCollectionProject.fromJson(list['listCollectionProject'][i]));
    }
    for (int i = 0; i < collectionListProject.length; i++) {
      if (index == i) {
        var lengthOfImageList = collectionListProject.elementAt(index).imageList.toList().length;
        for (int j = 0; j < lengthOfImageList; j++) {
          imageList.add(ModelImage.fromJson(list['listCollectionProject'][index]['imageList'][j]));
        }
      }
    }
    return imageList;
  }

  Future<List<ModelImage>> getImageListProject(int collectionId, int index, String modelId) async {
    final response = await http.get(Uri.parse(url + "api/v1/models/$modelId"));
    if (response.statusCode == 200) {
      var list = parseImageListProject(response.body, index);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }

  List<ModelImage> parseImageListBodyPart(String responseBody, int index) {
    int count = 0;
    var list = jsonDecode(responseBody);
    List<ModelImage> imageList = new List<ModelImage>();
    List<ListCollectionBodyPart> collectionListProject = new List<ListCollectionBodyPart>();
    list['listCollectionBody'].map((e) => count++).toList();
    for (int i = 0; i < count; i++) {
      collectionListProject.add(ListCollectionBodyPart.fromJson(list['listCollectionBody'][i]));
    }
    for (int i = 0; i < collectionListProject.length; i++) {
      if (index == i) {
        var lengthOfImageList = collectionListProject.elementAt(index).imageList.toList().length;
        for (int j = 0; j < lengthOfImageList; j++) {
          imageList.add(ModelImage.fromJson(list['listCollectionBody'][index]['imageList'][j]));
        }
      }
    }
    return imageList;
  }

  Future<List<ModelImage>> getImageListBodyPart(int collectionId, int index, String modelId) async {
    final response = await http.get(Uri.parse(url + "api/v1/models/$modelId"));
    if (response.statusCode == 200) {
      var list = parseImageListBodyPart(response.body, index);
      return list;
    } else {
      throw Exception('Failed to load');
    }
  }
  // List<ModelImage> parseImageList(String responseBody) {
  //   int count = 0;
  //   var list = jsonDecode(responseBody);
  //   List<ModelImage> imageList = new List<ModelImage>();
  //   var fetchList = list['listCollectionProject'];
  //   fetchList.map((e) => count++).toList();
  //   for (int i = 0; i < count; i++) {
  //     print('Gia tri count :'+ list['listCollectionProject']);
  //     imageList.add(ModelImage.fromJson(list['listCollectionProject']));
  //   }
  //   return imageList;
  // }
  //
  // Future<List<ModelImage>> getImageList(int collectionId) async {
  //   //var token = (await FlutterSession().get("token")).toString();
  //   // Map<String, String> heads = Map<String, String>();
  //   // heads['Content-Type'] = 'application/json';
  //   // heads['Accept'] = 'application/json';
  //   // heads['Authorization'] = 'Bearer $token';
  //   // final response = await http.get(
  //   //     Uri.parse(baseUrl + "api/v1/images/$collectionId"),
  //   //    headers: heads);
  //   final response = await http.get(Uri.parse(url + "api/v1/models/1"));
  //   if (response.statusCode == 200) {
  //     var list = parseImageList(response.body);
  //     return list;
  //   } else {
  //     throw Exception('Failed to load');
  //   }
  // }





/*

  Future<String> uploadFireBase(String path, String modelId) async {
    var token = (await FlutterSession().get("token")).toString();
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    heads['Authorization'] = 'Bearer $token';
    final _firebaseStorage = FirebaseStorage.instance;

    var file = File(path);

    var snapshot = await _firebaseStorage
        .ref()
        .child('models/' + modelId + "/avatar/images.jpg")
        .putFile(file);
    var downloadUrl = await snapshot.ref.getDownloadURL();

    Map<String, dynamic> params = Map<String, dynamic>();
    params['id'] = modelId;
    params['avatar'] = downloadUrl;

    final message = jsonEncode(params);
    final response = await http.put(
        Uri.parse(baseUrl + 'api/v1/models/${params["id"]}/avatar'),
        body: message,
        headers: heads);
    if (response.statusCode == 200) {
      return downloadUrl;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future uploadImage(int collectionId) async {
    var token = (await FlutterSession().get("token")).toString();
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    heads['Authorization'] = 'Bearer $token';
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Select Image
    image = await _imagePicker.getImage(source: ImageSource.gallery);
    var file = File(image.path);
    String modelId = (await FlutterSession().get('modelId')).toString();
    if (image != null) {
      //Upload to Firebase
      var snapshot = await _firebaseStorage
          .ref()
          .child('models/' +
          modelId +
          '/body/M' +
          DateTime.now().toString() +
          '.jpg')
          .putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();

      Map<String, dynamic> params = Map<String, dynamic>();
      params['fileName'] = downloadUrl;

      final message = jsonEncode(params);
      final response = await http.post(
          Uri.parse(baseUrl + 'api/v1/models/$modelId/$collectionId/image'),
          body: message,
          headers: heads);
      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to load');
      }
    }
  }

  Future deleteImage(String imageFileUrl, int imageId) async {
    var ids = [imageId];
    String modelId = (await FlutterSession().get('modelId')).toString();
    Map<String, dynamic> params = Map<String, dynamic>();
    params['id'] = ids;
    final message = jsonEncode(params);

    var token = (await FlutterSession().get("token")).toString();
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    heads['Authorization'] = 'Bearer $token';

    var fileUrl = Uri.decodeFull(Path.basename(imageFileUrl))
        .replaceAll(new RegExp(r'(\?alt).*'), '');
    final firebaseStorageRef = FirebaseStorage.instance.ref().child(fileUrl);
    await firebaseStorageRef.delete();

    final response = await http.put(
        Uri.parse(baseUrl + 'api/v1/models/$modelId/image'),
        body: message,
        headers: heads);
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load');
    }
  }

  // List<int> generateGIF(Iterable<Image> images) async {
  //   var token = (await FlutterSession().get("token")).toString();
  //   Map<String, String> heads = Map<String, String>();
  //   heads['Content-Type'] = 'application/json';
  //   heads['Accept'] = 'application/json';
  //   heads['Authorization'] = 'Bearer $token';
  // }

  Future<void> saveGif(ImageCollectionGif gif, int collecttionId) async {
    String modelId = (await FlutterSession().get('modelId')).toString();
    // final _firebaseStorage = FirebaseStorage.instance;

    // File('assets/img/${gif.Url}').create();
    // var file = File('assets/img/${gif.Url}');

    // var snapshot = await _firebaseStorage
    //     .ref()
    //     .child('models/' + modelId + "/gif/${gif.FileName}")
    //     .putString(gif.Url);

    // var downloadUrl = await snapshot.ref.getDownloadURL();

    Map<String, dynamic> params = Map<String, dynamic>();
    params['collectionId'] = collecttionId;
    params['gif'] = gif.Url;

    var token = (await FlutterSession().get("token")).toString();
    Map<String, String> heads = Map<String, String>();
    heads['Content-Type'] = 'application/json';
    heads['Accept'] = 'application/json';
    heads['Authorization'] = 'Bearer $token';

    final message = jsonEncode(params);
    final response = await http.put(
        Uri.parse(baseUrl + 'api/v1/collection-images/$modelId/gif'),
        body: message,
        headers: heads);
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load');
    }
  }
*/

}
