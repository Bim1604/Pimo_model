import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';
import 'package:pimo/screens/search.dart';
import 'package:pimo/widgets/home_view.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'casting_detail.dart';

class MainScreen extends StatelessWidget with ChangeNotifier {
  List data;
  Future<List> fetchCasting() async {
    final response =
        await http.get(Uri.parse('https://api.pimo.studio/api/v1/castings'));
    if (response.statusCode == 200) {
      var test = json.decode(response.body);
      data = test["castings"];
      return data;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List> getEvents;
  DateTime now = new DateTime.now();
  String getFormattedDate(String date) {
    var localDate = DateTime.parse(date).toLocal();

    /// inputFormat - format getting from api or other func.
    /// e.g If 2021-05-27 9:34:12.781341 then format should be yyyy-MM-dd HH:mm
    /// If 27/05/2021 9:34:12.781341 then format should be dd/MM/yyyy HH:mm
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());

    /// outputFormat - convert into format you want to show.
    var outputFormat = DateFormat('HH:mm dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; //Total height and width of the screen
    var height = MediaQuery.of(context).size.height;
    var width = size.width;
    getEvents = fetchCasting();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              HeaderWithSearchBox(size: size),
              const TitleWithButton(
                text: "Sự kiện sắp tới",
                isBooking: true,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: FutureBuilder<List>(
                    future: getEvents,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List listUpcoming = snapshot.data
                            .where((element) =>
                                DateTime.parse(element["casting"]["closeTime"])
                                    .isAfter(now))
                            .toList();

                        return CarouselSlider(
                          options: CarouselOptions(
                            height: height / 5,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: listUpcoming.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return CardHorizontal(
                                    title: "${i["casting"]["name"]}",
                                    openTime: getFormattedDate(
                                        "${i["casting"]["openTime"]}"),
                                    closeTime: getFormattedDate(
                                        "${i["casting"]["closeTime"]}"),
                                    img: i["casting"]["poster"],
                                    tap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CastingDetail(
                                              id: i["casting"]["id"].toString(),
                                            ),
                                          ));
                                    });
                              },
                            );
                          }).toList(),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
              const TitleWithButton(
                text: "Casting mới",
              ),
              FutureBuilder<List>(
                  future: getEvents,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List listUpcoming = snapshot.data
                          .where((element) =>
                              DateTime.parse(element["casting"]["closeTime"])
                                  .isAfter(now))
                          .toList();

                      return CarouselSlider(
                        options: CarouselOptions(
                          height: height / 5,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          //enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: listUpcoming.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return CardHorizontal(
                                  // cta: "${snapshot.data.description}",
                                  title: "${i["casting"]["name"]}",
                                  openTime: getFormattedDate(
                                      "${i["casting"]["openTime"]}"),
                                  closeTime: getFormattedDate(
                                      "${i["casting"]["closeTime"]}"),
                                  img: i["casting"]["poster"],
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CastingDetail(
                                            id: i["casting"]["id"].toString(),
                                          ),
                                        ));
                                  });
                            },
                          );
                        }).toList(),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
              const TitleWithButton(
                text: "Tốt nhất dành cho bạn",
              ),
              FutureBuilder<List>(
                  future: getEvents,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List list = snapshot.data
                          .where((element) =>
                              DateTime.parse(element["casting"]["closeTime"])
                                  .isAfter(now))
                          .toList();

                      return CarouselSlider(
                        options: CarouselOptions(
                          height: height / 5,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          //enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: list.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return CardHorizontal(
                                  // cta: "${snapshot.data.description}",
                                  title: "${i["casting"]["name"]}",
                                  openTime: getFormattedDate(
                                      "${i["casting"]["openTime"]}"),
                                  closeTime: getFormattedDate(
                                      "${i["casting"]["closeTime"]}"),
                                  img: i["casting"]["poster"],
                                  tap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CastingDetail(
                                            id: i["casting"]["id"].toString(),
                                          ),
                                        ));
                                  });
                            },
                          );
                        }).toList(),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        height: size.height * 0.2,
        child: Stack(children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 36 + 20.0,
            ),
            height: size.height * 0.2 - 12,
            decoration: const BoxDecoration(
                color: Color(0xFFf5a6b9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36))),
            child: Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: SizedBox(
                      width: 300,
                      child: FutureBuilder(
                        future: FlutterSession().get('modelName'),
                        builder: (context, snapshot) {
                          return Text(
                            'Xin chào ' + snapshot.data.toString() + '!',
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                    ),
                          );
                        },
                      ),
                    )),
                const Spacer(),
                // Image.asset(name)
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
                child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    height: 54,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Color(0xFFf5a6b9).withOpacity(0.23))
                        ]),
                    child: ElevatedButton(
                      child: Row(
                        children: const <Widget>[
                          Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 5,
                            width: 20,
                          ),
                          Text(
                            'Tìm kiếm',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Search()));
                      },
                    ))),
          ),
        ]));
  }
}

class TitleWithButton extends StatelessWidget {
  const TitleWithButton({Key key, this.text, this.isBooking = false})
      : super(key: key);

  final String text;
  final bool isBooking;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(children: <Widget>[
        TitleWithCustomUnderline(
          text: text,
        ),
        Spacer(),
        FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: const Color(0xFFf5a6b9),
            // onPressed: () {
            //   if (text == 'Notification') {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => NotificationPage(),
            //         ));
            //   } else {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => MultiProvider(
            //               providers: [
            //                 ChangeNotifierProvider(
            //                     create: (_) => CastingListViewModel()),
            //               ],
            //               child: FutureBuilder(
            //                 builder: (context, snapshot) {
            //                   return !isBooking
            //                       ? SearchCastingPage(
            //                     name: '',
            //                     min: '',
            //                     max: '',
            //                   )
            //                       : IncomingCastingPage();
            //                 },
            //               ))),
            //     );
            //   }
            // },
            child: const Text(
              '',
              style: TextStyle(color: Colors.black),
            ))
      ]),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0 / 4),
            child: Text(
              text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(right: 20.0 / 4),
                height: 7,
                color: const Color(0xFFf5a6b9).withOpacity(0.2),
              ))
        ],
      ),
    );
  }
}
