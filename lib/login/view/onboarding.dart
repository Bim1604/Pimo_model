import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pimo/login/view_models/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'assets/img/imgBackGround/3.png',
  'assets/img/imgBackGround/2.png',
  'assets/img/imgBackGround/1.png',
];

class Onboarding extends StatelessWidget {
  const Onboarding({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: const Color.fromRGBO(29, 9, 8, 0.7),
        body: Stack(children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: height,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: imgList.map<Widget>((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Stack(
                    children: [
                      Opacity(
                        opacity: 0.3,
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(i),
                            fit: BoxFit.fill,
                          )),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 13, top: height / 10),
                          child: Expanded(
                            child: Row(
                              children: [
                                const Text(
                                  'Welcome to ',
                                  style: TextStyle(
                                      color: Color(0XFFFFFFFF),
                                      fontSize: 16,
                                      fontFamily: 'Montserrat'),
                                ),
                                const Text(
                                  'Pi Muse ',
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 183, 180, 1),
                                      fontSize: 16,
                                      fontFamily: 'Montserrat'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width / 3.3),
                                  child: Container(
                                    width: 16,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xFF959595),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(28.0),
                                    ),
                                    child: Image.asset(
                                        'assets/img/Icon/Question.png'),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: height / 8),
                        child: Column(
                          children: <Widget>[
                            Image.asset('assets/img/Logo/Logo.png'),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          if (imgList.indexOf(i) == 0) ...[
                            Padding(
                              padding:
                                  EdgeInsets.only(top: height / 2.0, left: 13),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Pi MUSE',
                                      style: TextStyle(
                                          color: Color(0xFFFFB7B4),
                                          fontSize: 32,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700)),
                                  Text('PI A MUSE',
                                      style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 32,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
                          ] else if (imgList.indexOf(i) == 1) ...[
                            Padding(
                              padding:
                                  EdgeInsets.only(top: height / 2.3, left: 13),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('TOP LOCAL',
                                      style: TextStyle(
                                          color: Color(0xFFFFB7B4),
                                          fontSize: 32,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700)),
                                  Row(
                                    children: const [
                                      Text('MODELS, ',
                                          style: TextStyle(
                                              color: Color(0xFFFFB7B4),
                                              fontSize: 32,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w700)),
                                      Text('ALL IN',
                                          style: TextStyle(
                                              color: Color(0xFFFFFFFF),
                                              fontSize: 32,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                  const Text('ONE PLACE',
                                      style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 32,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700))
                                ],
                              ),
                            ),
                          ] else ...[
                            Padding(
                              padding:
                                  EdgeInsets.only(top: height / 2.3, left: 13),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('START',
                                      style: TextStyle(
                                          color: Color(0xFFFFB7B4),
                                          fontSize: 32,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700)),
                                  Text('MAKING MONEY',
                                      style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 32,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700)),
                                  Text('TODAY',
                                      style: TextStyle(
                                          color: Color(0xFFFFB7B4),
                                          fontSize: 32,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700))
                                ],
                              ),
                            ),
                          ]
                        ],
                      ),
                      Row(
                        children: imgList.map((e) {
                          if (imgList.indexOf(e) == imgList.indexOf(i)) {
                            return Positioned(
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: height / 1.6, left: 13),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xFFFFB7B4),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        width: 30,
                                        height: 2,
                                      )
                                    ],
                                  )),
                            );
                          } else {
                            return Positioned(
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: height / 1.6, left: 13),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xFFFFFFFF),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        width: 15,
                                        height: 2,
                                      )
                                    ],
                                  )),
                            );
                          }
                        }).toList(),
                      ),
                    ],
                  );
                },
              );
            }).toList(),
          ),
          Container(
            width: width,
            height: height,
            padding: EdgeInsets.only(bottom: height / 25),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 13),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      width: width,
                      height: 54,
                      child: FlatButton(
                        textColor: const Color(0xFFFFFFFF),
                        color: Colors.transparent,
                        onPressed: () {
                          //setup firebase
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin().then((value) =>
                              Navigator.pushReplacementNamed(
                                  context, '/signup'));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 8, top: 8, bottom: 8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text("SIGN UP",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat',
                                        fontSize: 16.0)),
                              ]),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 13, right: 13, top: 20, bottom: height / 40),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(255, 183, 180, 1),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      width: width,
                      height: 54,
                      child: FlatButton(
                        textColor: Colors.black,
                        color: const Color.fromRGBO(255, 183, 180, 1),
                        onPressed: () {
                          //setup firebase
                          // final provider = Provider.of<GoogleSignInProvider>(
                          //     context,
                          //     listen: false);
                          // provider.googleLogin().then((value) =>
                          //     Navigator.pushReplacementNamed(
                          //         context, '/authentication'));
                          Navigator.pushReplacementNamed(context, '/signIn');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 8, top: 8, bottom: 8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text("SIGN IN",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat',
                                        fontSize: 16.0)),
                              ]),
                        ),
                      ),
                    ),
                  ),
                  const Center(
                      child: Text("By joining in you accept out",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13.0,
                              color: Color(0xFF959595),
                              fontFamily: 'Montserrat'),
                          textAlign: TextAlign.center)),
                  const Center(
                    child: Text('terms and conditions',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13.0,
                            fontFamily: 'Montserrat',
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                            color: Color(0xFFFFB7B4))),
                  )
                ],
              ),
            ),
          ),
        ]));
  }
}
