import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pimo/constants/Theme.dart';

import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:pimo/widgets/home_view.dart';

import 'casting_detail.dart';

class SearchResult extends StatelessWidget with ChangeNotifier {
  final String name;
  final String address;
  final String openDate;
  final String closeDate;
  final List<int> selectedGenders;
  final List<int> selectedStyles;

  SearchResult(
      {this.name = "",
      this.closeDate = "2021-12-02",
      this.openDate = "2021-10-02",
      this.selectedGenders,
      this.selectedStyles,
      this.address});

  List results = [];
  Future<List> fetchCasting(
      String name,
      String address,
      String openTime,
      String closeTime,
      List<int> selectedStyles,
      List<int> selectedGenders) async {
    var url = 'https://api.pimo.studio/api/v1/castings?';
    if (openTime.isNotEmpty) {
      url = url + '&StartTime=${openTime}';
      openTime = DateTime.parse(openTime).toIso8601String();
    }
    if (closeTime.isNotEmpty) {
      url = url + '&EndTime=${closeTime}';
      closeTime = DateTime.parse(closeTime).toIso8601String();
    }
    if (name.isNotEmpty) {
      url = url + '&Name=${name}';
    }
    if (address.isNotEmpty) {
      url = url + '&Address=${address}';
    }
    if (selectedStyles.isNotEmpty) {
      for (var i = 0; i < selectedStyles.length; i++) {
        url = url + '&Styles=${selectedStyles[i]}';
      }
    }
    if (selectedGenders.isNotEmpty) {
      for (var i = 0; i < selectedGenders.length; i++) {
        url = url + '&Genders=${selectedGenders[i]}';
      }
    }
    print(url);
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);

    if (response.statusCode == 200) {
      var test = json.decode(response.body);

      var b = test["castings"];
      return b;
    } else {
      throw Exception('Failed to load album');
    }
  }

  String getFormattedDate(String date) {
    var localDate = DateTime.parse(date).toLocal();

    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());

    var outputFormat = DateFormat('HH:mm dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  Future<List> getEvents;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    getEvents = fetchCasting(
        name, address, openDate, closeDate, selectedStyles, selectedGenders);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          backgroundColor: MaterialColors.mainColor,
          elevation: 0,
          title: const Text(
            'Kết quả tìm kiếm',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FutureBuilder<List>(
                  future: getEvents,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List list = snapshot.data;
                      return Container(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: list.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) =>
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: CardHorizontal(
                                      title:
                                          "${list[index]["casting"]["name"]}",
                                      openTime: getFormattedDate(
                                          "${list[index]["casting"]["openTime"]}"),
                                      closeTime: getFormattedDate(
                                          "${list[index]["casting"]["closeTime"]}"),
                                      img: list[index]["casting"]["poster"],
                                      tap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => CastingDetail(
                                                id: list[index]["casting"]["id"]
                                                    .toString(),
                                              ),
                                            ));
                                      }),
                                )),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
