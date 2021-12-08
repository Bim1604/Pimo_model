import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pimo/constants/Images.dart';
import 'package:pimo/constants/Theme.dart';
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';
import 'package:pimo/viewmodels/model_availiable_model.dart';
import 'package:pimo/viewmodels/model_view_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'model_profile.dart';
import 'package:http/http.dart' as http;

class AvailibleDetailsPage extends StatefulWidget {
  final int modelId;
  final int id;
  final String startDate;
  final String endDate;
  final String location;
  const AvailibleDetailsPage(
      {Key key,
      this.modelId,
      this.id,
      this.startDate,
      this.endDate,
      this.location})
      : super(key: key);

  @override
  _AvailibleDetailsPageState createState() => _AvailibleDetailsPageState();
}

class _AvailibleDetailsPageState extends State<AvailibleDetailsPage> {
  @override
  void initState() {
    super.initState();
    print(widget.startDate);
  }

  deleteAvailiable(int availibleId) async {
    String jwt = (await FlutterSession().get('jwt')).toString();
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
      'Authorization': 'Bearer ' + jwt
    };
    var msg = "Xoá thất bại";
    var response = await http.delete(
        Uri.parse('https://api.pimo.studio/api/v1/availabilities'),
        headers: headers,
        body: jsonEncode(availibleId));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (body["success"]) {
        msg = "Đã xoá";
      }
    } else {
      msg = "Xoá thất bại";
    }

    return Fluttertoast.showToast(
        msg: msg, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
  }

  Future _showDialog(BuildContext context, int availibleId) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Bạn chắc chắn muốn xóa?",
              style: TextStyle(color: MaterialColors.mainColor),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Hủy',
                  style: TextStyle(color: Colors.grey),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 0,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await deleteAvailiable(availibleId);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Xóa',
                  style: TextStyle(color: MaterialColors.mainColor),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 0,
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MaterialColors.mainColor,
          title: Text('Chi tiết lịch trình'),
          actions: [
            IconButton(
                onPressed: () {
                  _showDialog(context, widget.id);
                },
                icon: const Icon(Icons.delete_forever_outlined))
          ],
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
                      modelId: widget.modelId,
                      id: widget.id,
                      startDate: widget.startDate,
                      endDate: widget.endDate,
                      location: widget.location,
                    );
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
  final int id;
  final int modelId;
  final String startDate;
  final String endDate;
  final String location;
  const AvailibleCreate(
      {Key key,
      this.id,
      this.modelId,
      this.startDate,
      this.endDate,
      this.location})
      : super(key: key);

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

  loading() {
    startDateController.text = widget.startDate;
    endDateController.text = widget.endDate;
    locationController.text = widget.location;
  }

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

  updateAvailible() async {
    var jwt = (await FlutterSession().get("jwt")).toString();
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      "Access-Control-Allow-Origin": "*",
      'Authorization': 'Bearer ' + jwt,
    };
    var response = await http.put(
        Uri.parse('https://api.pimo.studio/api/v1/availabilities'),
        headers: headers,
        body: jsonEncode({
          "id": widget.id,
          "startDate": startDateController.text,
          "endDate": endDateController.text,
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
    loading();
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
              SizedBox(
                height: 15,
              ),
            ],
          ),
          ElevatedButton(
            child: Text('Cập nhật', style: TextStyle(color: Colors.black)),
            onPressed: () async {
              updateAvailible();
              Navigator.pop(
                context,
              );
            },
            style: ElevatedButton.styleFrom(
                primary: MaterialColors.mainColor,
                elevation: 0,
                minimumSize: Size(10, 40)),
          ),
        ],
      ),
    );
  }
}
