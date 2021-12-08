import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pimo/utils/google_sign_in.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://vcdn-sohoa.vnecdn.net/2019/08/13/anh-vit-4994-1563184203-8682-1565668951.gif"),
                  fit: BoxFit.fitHeight))),
      Padding(
        padding: const EdgeInsets.only(left: 75, right: 45, bottom: 16),
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.only(bottom: 30),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  //Chỉnh khung
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.pinkAccent,
                        width: 2.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: width * 0.6,
                    child: FlatButton(
                      textColor: Colors.pinkAccent,
                      color: Colors.white,
                      onPressed: () {
                        //setup firebase
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin().then((value) =>
                            Navigator.pushReplacementNamed(
                                context, '/authentication'));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 8, top: 8, bottom: 8),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/img/logo.png",
                                height: 30,
                                width: 30,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text("ĐĂNG NHẬP VỚI GOOGLE",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.0)),
                              )
                            ]),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    ]));
  }
}
