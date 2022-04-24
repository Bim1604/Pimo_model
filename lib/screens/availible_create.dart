import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';
import 'package:pimo/viewmodels/model_availiable_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AvailibleCreatePage extends StatefulWidget {
  final int modelId;
  const AvailibleCreatePage({Key key, this.modelId}) : super(key: key);

  @override
  _AvailibleCreatePageState createState() => _AvailibleCreatePageState();
}

class _AvailibleCreatePageState extends State<AvailibleCreatePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Tạo lịch trình mới',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: FutureBuilder<AvailibleListViewModel>(
              future:
                  Provider.of<AvailibleListViewModel>(context, listen: false)
                      .getAvailibleView(widget.modelId),
              builder: (ctx, prevData) {
                if (prevData.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                      ),
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                } else {
                  if (prevData.error == null) {
                    return AvailibleCreate(
                        modelDetail: Provider.of<AvailibleListViewModel>(
                            context,
                            listen: false));
                  } else {
                    return Text('Lỗi');
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AvailibleCreate extends StatefulWidget {
  final AvailibleListViewModel modelDetail;
  const AvailibleCreate({Key key, this.modelDetail}) : super(key: key);

  @override
  _AvailibleCreateState createState() => _AvailibleCreateState();
}

class _AvailibleCreateState extends State<AvailibleCreate> {
  String startDate;
  String endDate;
  String location;
  DateTime _selectedDate;

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final locationController = TextEditingController();

  void _setOpenTimeValue() {
    setState(() {
      startDate = startDateController.text;
    });
  }

  void _setEndTimeValue() {
    setState(() {
      endDate = endDateController.text;
    });
  }

  createAvailible() async {
    var jwt = (await FlutterSession().get("jwt")).toString();
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
      'Authorization': 'Bearer ' + jwt,
    };
    var response = await http.post(
        Uri.parse('https://api.pimo.studio/api/v1/availabilities'),
        headers: headers,
        body: jsonEncode({
          "startDate": startDate,
          "endDate": endDate,
          "location": location,
        }));
    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Cập nhật thành công');
      } else {
        throw Exception("Something wrong in update profile");
      }
    } on Exception catch (exception) {
      print("Exception: " + exception.toString());
    } catch (error) {
      print("ERROR: " + error.toString());
    }
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
      startDateController
        ..text = _selectedDate.toString()
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: startDateController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  _selectEndDate(BuildContext context) async {
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
      endDateController
        ..text = _selectedDate.toString()
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: endDateController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    startDateController.addListener(_setOpenTimeValue);
    endDateController.addListener(_setEndTimeValue);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.all(30),
            children: [
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
                controller: startDateController,
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
                controller: endDateController,
                onTap: () {
                  _selectEndDate(context);
                },
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.schedule),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Địa điểm ",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic),
                ),
              ),
              TextField(
                  controller: locationController,
                  onChanged: (newText) {
                    setState(() {
                      location = newText;
                    });
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    suffixIcon: Icon(Icons.location_city),
                  )),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
          ElevatedButton(
            child: const Text('Tạo', style: TextStyle(color: Colors.black)),
            onPressed: () async {
              createAvailible();
              Navigator.pop(
                context,
              );
            },
            style: ElevatedButton.styleFrom(
                primary: MaterialColors.mainColor,
                elevation: 0,
                minimumSize: const Size(10, 40)),
          ),
        ],
      ),
    );
  }
}
