import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/screens/search_result.dart';


import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final openController = TextEditingController();
  final closeController = TextEditingController();

  Future<List> getAllStyles() async {
    final response =
        await http.get(Uri.parse('https://api.pimo.studio/api/v1/styles'));
    if (response.statusCode == 200) {
      var test = json.decode(response.body);
      return test["style"];
    } else {
      throw Exception('Failed to load album');
    }
  }

  DateTime _selectedDate;
  String name = "";
  String address = "";
  String openTime = "";
  String closeTime = "";

  // GenderChecked
  bool isMaleChecked = false;
  bool isFemaleChecked = false;
  bool isAnotherSexChecked = false;

// StyleChecked

  bool isSexyChecked = false;
  bool isClassesChecked = false;
  bool isStreetChecked = false;
  bool isSummerChecked = false;
  bool isWinterChecked = false;
  bool isPositiveChecked = false;
  bool isNudeChecked = false;
  bool isArtChecked = false;

  List sexList = [
    {"id": 1, "name": 'Nam'},
    {"id": 2, "name": 'Nữ'},
    {"id": 3, "name": 'Khác'},
  ];

  List<int> selectedGenders = List();
  List<int> selectedStyles = List();
  // Change State Open Time
  void _setOpenTimeValue() {
    setState(() {
      openTime = openController.text;
    });
  }

  // Change State Close Time
  void _setCloseTimeValue() {
    setState(() {
      closeTime = closeController.text;
    });
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    openController.addListener(_setOpenTimeValue);
    closeController.addListener(_setCloseTimeValue);
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    openController.dispose();
    closeController.dispose();
    super.dispose();
  }

  Future<List> getListStyles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          backgroundColor: MaterialColors.mainColor,
          elevation: 0,
          title: const Text(
            'Tìm kiếm Chiến dịch',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: MaterialColors.bgColorScreen,
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: MaterialColors.mainColor.withOpacity(0.5),
                    offset: Offset(0, 5),
                    blurRadius: 10,
                  )
                ]),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            child: Wrap(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Tên sự kiện",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.pinkAccent,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                TextField(
                                    controller: nameController,
                                    onChanged: (newText) {
                                      setState(() {
                                        name = newText;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Nhập tên sự kiện',
                                    )),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Địa chỉ sự kiện",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.pinkAccent,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                TextField(
                                    controller: addressController,
                                    onChanged: (newText) {
                                      setState(() {
                                        address = newText;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Nhập địa chỉ sự kiện',
                                    )),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Thời gian bắt đầu",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.pinkAccent,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                TextField(
                                  readOnly: true,
                                  controller: openController,
                                  onTap: () {
                                    _selectOpenDate(context);
                                  },
                                  decoration: const InputDecoration(
                                    suffixIcon: Icon(Icons.schedule),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Thời gian kết thúc",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.pinkAccent,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                TextField(
                                  readOnly: true,
                                  controller: closeController,
                                  onTap: () {
                                    _selectCloseDate(context);
                                  },
                                  decoration: const InputDecoration(
                                    suffixIcon: Icon(Icons.schedule),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Giới tính",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.pinkAccent,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: sexList.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => Row(
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.white,
                                        fillColor:
                                            MaterialStateProperty.all<Color>(
                                                MaterialColors.mainColor),
                                        value: index == 0
                                            ? isMaleChecked
                                            : (index == 1
                                                ? isFemaleChecked
                                                : isAnotherSexChecked),
                                        onChanged: (bool value) {
                                          setState(() {
                                            if (sexList[index]["name"] ==
                                                "Nam") {
                                              isMaleChecked = value;
                                              if (value == true) {
                                                selectedGenders.add(index + 1);
                                              } else {
                                                selectedGenders
                                                    .remove(index + 1);
                                              }
                                            } else if (sexList[index]["name"] ==
                                                "Nữ") {
                                              isFemaleChecked = value;
                                              if (value == true) {
                                                selectedGenders.add(index + 1);
                                              } else {
                                                selectedGenders
                                                    .remove(index + 1);
                                              }
                                            } else {
                                              isAnotherSexChecked = value;
                                              if (value == true) {
                                                selectedGenders.add(index + 1);
                                              } else {
                                                selectedGenders
                                                    .remove(index + 1);
                                              }
                                            }
                                          });
                                        },
                                        activeColor: Colors.pinkAccent,
                                      ),
                                      Text(sexList[index]["name"])
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Phong cách",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.pinkAccent,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    FutureBuilder<List>(
                                        future: getAllStyles(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            // print(snapshot.data);
                                            List list1 = snapshot.data
                                                .getRange(0,
                                                    snapshot.data.length ~/ 2)
                                                .toList();
                                            List list2 = snapshot.data
                                                .getRange(
                                                    snapshot.data.length ~/ 2,
                                                    snapshot.data.length)
                                                .toList();
                                            return Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: list1.length,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) => Row(
                                                      children: [
                                                        Checkbox(
                                                          checkColor:
                                                              Colors.white,
                                                          fillColor:
                                                              MaterialStateProperty.all<
                                                                      Color>(
                                                                  MaterialColors
                                                                      .mainColor),
                                                          value: index == 0
                                                              ? isSexyChecked
                                                              : (index == 1
                                                                  ? isClassesChecked
                                                                  : (index == 2
                                                                      ? isStreetChecked
                                                                      : isSummerChecked)),
                                                          onChanged:
                                                              (bool value) {
                                                            setState(() {
                                                              if (list1[index][
                                                                      "name"] ==
                                                                  "Gợi cảm") {
                                                                print(value);
                                                                isSexyChecked =
                                                                    value;
                                                                if (value ==
                                                                    true) {
                                                                  selectedStyles
                                                                      .add(index +
                                                                          1);
                                                                } else {
                                                                  selectedStyles
                                                                      .remove(
                                                                          index +
                                                                              1);
                                                                }
                                                              } else if (list1[
                                                                          index]
                                                                      [
                                                                      "name"] ==
                                                                  "Cổ điển") {
                                                                isClassesChecked =
                                                                    value;
                                                                if (value ==
                                                                    true) {
                                                                  selectedStyles
                                                                      .add(index +
                                                                          1);
                                                                } else {
                                                                  selectedStyles
                                                                      .remove(
                                                                          index +
                                                                              1);
                                                                }
                                                              } else if (list1[
                                                                          index]
                                                                      [
                                                                      "name"] ==
                                                                  "Đường phố") {
                                                                isStreetChecked =
                                                                    value;
                                                                if (value ==
                                                                    true) {
                                                                  selectedStyles
                                                                      .add(index +
                                                                          1);
                                                                } else {
                                                                  selectedStyles
                                                                      .remove(
                                                                          index +
                                                                              1);
                                                                }
                                                              } else {
                                                                isSummerChecked =
                                                                    value;
                                                                if (value ==
                                                                    true) {
                                                                  selectedStyles
                                                                      .add(index +
                                                                          1);
                                                                } else {
                                                                  selectedStyles
                                                                      .remove(
                                                                          index +
                                                                              1);
                                                                }
                                                              }
                                                            });
                                                          },
                                                        ),
                                                        Text(list1[index]
                                                            ["name"])
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: list2.length,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) => Row(
                                                      children: [
                                                        Checkbox(
                                                          checkColor:
                                                              Colors.white,
                                                          fillColor:
                                                              MaterialStateProperty.all<
                                                                      Color>(
                                                                  MaterialColors
                                                                      .mainColor),
                                                          value: index == 0
                                                              ? isWinterChecked
                                                              : (index == 1
                                                                  ? isPositiveChecked
                                                                  : (index == 2
                                                                      ? isNudeChecked
                                                                      : isArtChecked)),
                                                          onChanged:
                                                              (bool value) {
                                                            print(value);
                                                            setState(() {
                                                              if (list2[index][
                                                                      "name"] ==
                                                                  "Mùa đông") {
                                                                isWinterChecked =
                                                                    value;
                                                                if (value ==
                                                                    true) {
                                                                  selectedStyles
                                                                      .add(index +
                                                                          5);
                                                                } else {
                                                                  selectedStyles
                                                                      .remove(
                                                                          index +
                                                                              5);
                                                                }
                                                              } else if (list2[
                                                                          index]
                                                                      [
                                                                      "name"] ==
                                                                  "Năng động") {
                                                                isPositiveChecked =
                                                                    value;
                                                                if (value ==
                                                                    true) {
                                                                  selectedStyles
                                                                      .add(index +
                                                                          5);
                                                                } else {
                                                                  selectedStyles
                                                                      .remove(
                                                                          index +
                                                                              5);
                                                                }
                                                              } else if (list2[
                                                                          index]
                                                                      [
                                                                      "name"] ==
                                                                  "Nude") {
                                                                isNudeChecked =
                                                                    value;
                                                                if (value ==
                                                                    true) {
                                                                  selectedStyles
                                                                      .add(index +
                                                                          5);
                                                                } else {
                                                                  selectedStyles
                                                                      .remove(
                                                                          index +
                                                                              5);
                                                                }
                                                              } else {
                                                                isArtChecked =
                                                                    value;
                                                                if (value ==
                                                                    true) {
                                                                  selectedStyles
                                                                      .add(index +
                                                                          5);
                                                                } else {
                                                                  selectedStyles
                                                                      .remove(
                                                                          index +
                                                                              5);
                                                                }
                                                              }
                                                            });
                                                          },
                                                        ),
                                                        Text(list2[index]
                                                            ["name"])
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          } else {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                        })
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: RaisedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SearchResult(
                                                        name: name,
                                                        address: address,
                                                        openDate: openTime,
                                                        closeDate: closeTime,
                                                        selectedGenders:
                                                            selectedGenders,
                                                        selectedStyles:
                                                            selectedStyles,
                                                      )));
                                        },
                                        textColor: Colors.white,
                                        color: MaterialColors.mainColor,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16.0),
                                        child: const Text("Tìm kiếm",
                                            style: TextStyle(fontSize: 16))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: RaisedButton(
                                        onPressed: () {
                                          setState(() {
                                            name = "";
                                            closeTime = "";
                                            openTime = "";
                                          });
                                        },
                                        textColor: Colors.white,
                                        color: MaterialColors.mainColor,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16.0),
                                        child: const Text("Huỷ",
                                            style: TextStyle(fontSize: 16))),
                                  ),
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
        ])));
  }

  _selectOpenDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child,
          );
        });
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate = newSelectedDate;
      });
      openController
        ..text = _selectedDate.toString()
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: openController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  _selectCloseDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      setState(() {
        _selectedDate = newSelectedDate;
      });
      closeController
        ..text = _selectedDate.toString()
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: closeController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}
