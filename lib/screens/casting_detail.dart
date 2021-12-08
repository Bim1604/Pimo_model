import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';
import 'package:pimo/widgets/slider.dart';
import 'package:http/http.dart' as http;

class Casting extends StatelessWidget with ChangeNotifier {
  final double height = window.physicalSize.height;
  final String urlImg;
  final String title;
  final String brandName;
  final String logo;
  final String description;
  final String address;
  final String salary;
  final String openTime;
  final String closeTime;
  final List<dynamic> gender;
  final List<dynamic> style;
  final String request;
  final String id;

  Casting(
      {this.brandName = "Hello",
      this.logo = "",
      this.description = "Hello",
      this.address = "",
      this.salary = "",
      this.openTime = "",
      this.closeTime = "",
      this.gender = null,
      this.style = null,
      this.request = "",
      this.title = "Shoes",
      this.urlImg = "https://via.placeholder.com/250",
      this.id = ""});

  factory Casting.fromJson(Map<String, dynamic> json) {
    return Casting(
        brandName: json["brand"]["name"],
        logo: json["brand"]["logo"],
        description: json["casting"]["description"],
        address: json["casting"]["address"],
        salary: json["casting"]["salary"].toString(),
        openTime: json["casting"]["openTime"],
        closeTime: json["casting"]["closeTime"],
        gender: json["listGender"],
        style: json["listStyle"],
        request: json["casting"]["request"],
        title: json["casting"]["name"],
        urlImg: json["casting"]["poster"],
        id: json["casting"]["id"].toString());
  }

  applyCasting(String id) async {

    String accessToken = (await FlutterSession().get('jwt')).toString();
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
      'Authorization': 'Bearer ' + accessToken
    };
    var response = await http.post(
        Uri.parse('https://api.pimo.studio/api/v1/applies'),
        headers: headers,
        body: jsonEncode(id));

    var msg = "Ứng tuyển thất bại"; 
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (body["success"]) {
        msg = "Ứng tuyển thành công";
      }
    } else {
      msg = "Ứng tuyển thất bại";
      //throw Exception('Failed');
    }
    return Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final List<String> imgList = [urlImg];
    final double width = MediaQuery.of(context).size.width / 2;
    var genderString = "";
    if (gender.isNotEmpty) {
      genderString = gender[0]["genderName"].toString();
      for (var i = 1; i < gender.length; i++) {
        genderString = genderString + ", ";
        genderString = genderString + gender[i]["genderName"].toString();
      }
    }

    var styleString = "";
    if (style.isNotEmpty) {
      styleString = style[0]["name"].toString();
      for (var i = 1; i < style.length; i++) {
        styleString = styleString + ", ";
        styleString = styleString + style[i]["name"].toString();
      }
    }

    List<String> requestList = List<String>();
    if (request.isNotEmpty) {
      var listRequest = request.split("<br/>");
      for (var i = 1; i < listRequest.length; i++) {
        requestList.add(listRequest[i].toString());
      }
    } else {
      requestList.add("Không có yêu cầu.");
    }
    ;

    return Stack(children: [
      Container(height: 0.1 * height, child: ImageSlider(imgArray: imgList)),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 8,
                        blurRadius: 10,
                        offset: const Offset(0, 0))
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  )),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.28,
              ),
              alignment: Alignment.bottomCenter,
              child: Stack(children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    child: SafeArea(
                      bottom: true,
                      top: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 80.0),
                            child: Text(title,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Avatar
                              Padding(
                                padding:
                                    EdgeInsets.only(left: width / 3, top: 20),
                                child: Row(
                                  children: [
                                    Text("Được tạo bởi "),
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(logo),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(brandName,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Icon(Icons.info_outline_rounded,
                                        size: 20),
                                  ),
                                  Text("Thông tin chi tiết",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: MaterialColors.mainColor
                                        .withOpacity(0.5),
                                    offset: Offset(0, 5),
                                    blurRadius: 10,
                                  )
                                ]),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            child: Wrap(
                                              direction: Axis.horizontal,
                                              children: <Widget>[
                                                const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 5),
                                                    child: Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 16,
                                                    )),
                                                const Text(
                                                  'Địa chỉ: ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: MaterialColors
                                                          .mainColor),
                                                ),
                                                Text(
                                                  address,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            child: Wrap(
                                              direction: Axis.horizontal,
                                              children: <Widget>[
                                                const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 5),
                                                    child: Icon(
                                                      Icons.transgender,
                                                      size: 16,
                                                    )),
                                                const Text(
                                                  'Giới tính: ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: MaterialColors
                                                          .mainColor),
                                                ),
                                                Text(
                                                  genderString,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            child: Wrap(
                                              direction: Axis.horizontal,
                                              children: <Widget>[
                                                const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 5),
                                                    child: Icon(
                                                      Icons
                                                          .star_border_outlined,
                                                      size: 16,
                                                    )),
                                                const Text(
                                                  'Phong cách: ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: MaterialColors
                                                          .mainColor),
                                                ),
                                                Text(
                                                  styleString,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            child: Wrap(
                                              direction: Axis.horizontal,
                                              children: <Widget>[
                                                const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 5),
                                                    child: Icon(
                                                      Icons.schedule,
                                                      size: 16,
                                                    )),
                                                const Text(
                                                  'Thời gian: ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: MaterialColors
                                                          .mainColor),
                                                ),
                                                Text(
                                                  openTime + " - " + closeTime,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            child: Wrap(
                                              direction: Axis.horizontal,
                                              children: <Widget>[
                                                const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 5),
                                                    child: Icon(
                                                      Icons.attach_money,
                                                      size: 16,
                                                    )),
                                                const Text(
                                                  'Tiền lương: ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: MaterialColors
                                                          .mainColor),
                                                ),
                                                Text(
                                                  salary + " VND",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // ProductSizePicker(),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Icon(Icons.description_outlined,
                                        size: 20),
                                  ),
                                  Text("Mô tả",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: MaterialColors.mainColor
                                        .withOpacity(0.5),
                                    offset: Offset(0, 5),
                                    blurRadius: 10,
                                  )
                                ]),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            child: Wrap(
                                              direction: Axis.horizontal,
                                              children: <Widget>[
                                                Text(
                                                  description,
                                                  // softWrap: true,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Icon(Icons.request_page, size: 20),
                                  ),
                                  Text("Yêu cầu",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: MaterialColors.mainColor
                                        .withOpacity(0.5),
                                    offset: Offset(0, 5),
                                    blurRadius: 10,
                                  )
                                ]),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            child: Wrap(
                                              direction: Axis.horizontal,
                                              children: <Widget>[
                                                Expanded(
                                                  child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      shrinkWrap: true,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      itemCount:
                                                          requestList.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Text(
                                                          requestList[index],
                                                          // softWrap: true,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .black),
                                                        );
                                                      }),
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                  onPressed: () {
                                    applyCasting(id);
                                  },
                                  textColor: Colors.white,
                                  color: MaterialColors.mainColor,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16.0),
                                  child: const Text("ỨNG TUYỂN",
                                      style: TextStyle(fontSize: 16))),
                            ),
                          )
                        ],
                      ),
                    )),
              ])))
    ]);
  }
}

class CastingDetail extends StatelessWidget with ChangeNotifier {
  final double height = window.physicalSize.height;
  final String id;
  CastingDetail({this.id = ""});

  Future<Casting> fetchCasting(String id) async {
    final response = await http.get(
        Uri.parse('https://api.pimo.studio/api/v1/castings/information/${id}'));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return Casting.fromJson(body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Casting> getEvents;

  @override
  Widget build(BuildContext context) {
    getEvents = fetchCasting(id);
    return SafeArea(
        child: FutureBuilder<Casting>(
      future: fetchCasting(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                leading: Padding(
                  padding: EdgeInsets.only(left: 18, top: 18),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: MaterialColors.mainColor.withOpacity(0.5),
                            offset: Offset(0, 5),
                            blurRadius: 10,
                          )
                        ]),
                    child: const BackButton(
                      color: MaterialColors.mainColor,
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              backgroundColor: MaterialColors.bgColorScreen,
              body: SingleChildScrollView(
                  child: Casting(
                id: snapshot.data.id,
                brandName: snapshot.data.brandName,
                logo: snapshot.data.logo,
                description: snapshot.data.description,
                address: snapshot.data.address,
                salary: snapshot.data.salary,
                openTime: snapshot.data.openTime,
                closeTime: snapshot.data.closeTime,
                gender: snapshot.data.gender,
                style: snapshot.data.style,
                request: snapshot.data.request,
                title: snapshot.data.title,
                urlImg: snapshot.data.urlImg,
              )));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ));
  }
}
