import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:localstorage/localstorage.dart';

import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount _user;

  GoogleSignInAccount get user => _user;

  Future googleLogin() async {
    print('qua');
    try {
      final googleUser = await googleSignIn.signIn();
      print(googleUser);
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print('qua2');
      await FirebaseAuth.instance.signInWithCredential(credential);
      var idToken = await FirebaseAuth.instance.currentUser.getIdToken();
      var mail = FirebaseAuth.instance.currentUser.email;
      var token = {"token": idToken, "mail": mail};
      await FlutterSession().set("token", idToken);
      print('qua3');
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      var url = 'https://api.pimo.studio/api/v1/auth';
      HttpClientRequest request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(token)));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();
      final parseJson = jsonDecode(reply);
      Map<String, dynamic> payload = Jwt.parseJwt(parseJson['jwt']);
      await FlutterSession().set("jwt", parseJson['jwt']);
      var linkModelId =
          'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier';
      var linkRole =
          'http://schemas.microsoft.com/ws/2008/06/identity/claims/role';
      final LocalStorage storage = LocalStorage('localstorage_app');

      await storage.setItem('role', payload[linkRole].toString());
      print('quaa');
      if (parseJson['isExist'] == false) {
        Fluttertoast.showToast(
            msg:
                "Rất tiếc, bạn không thuộc trong hệ thống.\n Hãy đăng kí với admin. ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
        return logout();
      } else {
        await FlutterSession().set("modelId", payload[linkModelId]);
        await FlutterSession().set("modelName", parseJson['name']);
        var msg = "Bạn không có quyên truy cập vào app này";
        if (payload[linkRole].toString() == "Model") {
          msg = "Đăng nhập thành công";
        }
        Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
      }
    } catch (e) {
      print(e.toString());
      String msg = "Đã có lỗi xảy ra";
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
    }

    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    final LocalStorage storage = LocalStorage('localstorage_app');
    storage.deleteItem('role');
  }
}
