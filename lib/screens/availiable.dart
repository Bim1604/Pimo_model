import 'package:flutter/material.dart';
import 'package:pimo/screens/availible_create.dart';
import 'package:pimo/screens/availible_details.dart';
import 'package:pimo/viewmodels/model_availiable_model.dart';
import 'package:provider/provider.dart';
import 'package:pimo/constants/Theme.dart';

class AvailiableTemplatePage extends StatefulWidget {
  final int modelId;
  const AvailiableTemplatePage({Key key, this.modelId}) : super(key: key);
  @override
  _AvailiableTemplatePageState createState() => _AvailiableTemplatePageState();
}

class _AvailiableTemplatePageState extends State<AvailiableTemplatePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: MaterialColors.mainColor,
        title: const Text('Lịch trình sắp tới'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: SizedBox(
                  height: height / 1.5,
                  child: FutureBuilder<AvailibleListViewModel>(
                    future: Provider.of<AvailibleListViewModel>(context,
                            listen: false)
                        .getAvailibleView(widget.modelId),
                    builder: (ctx, prevData) {
                      if (prevData.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: const <Widget>[
                            SizedBox(
                              height: 150,
                            ),
                            Center(child: CircularProgressIndicator()),
                          ],
                        );
                      } else {
                        if (prevData.error == null) {
                          return Consumer<AvailibleListViewModel>(
                            builder: (ctx, data, child) => Center(
                                child: ListView.builder(
                                    padding: const EdgeInsets.only(top: 30),
                                    itemCount: data.listAvailiable.length,
                                    itemBuilder: (context, index) {
                                      return CompButton(
                                        modelId: widget.modelId,
                                        id: data.listAvailiable[index].id,
                                        startDate: data
                                            .listAvailiable[index].startDate,
                                        endDate:
                                            data.listAvailiable[index].endDate,
                                        location:
                                            data.listAvailiable[index].location,
                                      );
                                    })),
                          );
                        } else {
                          return const Text('Lỗi');
                        }
                      }
                    },
                  )),
            ),
            ElevatedButton(
              child: const Text('Tạo lịch trình',
                  style: TextStyle(color: Colors.black)),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiProvider(
                              providers: [
                                ChangeNotifierProvider(
                                  create: (_) => AvailibleListViewModel(),
                                ),
                              ],
                              child: FutureBuilder(
                                builder: (context, snapshot) {
                                  return AvailibleCreatePage(
                                    modelId: widget.modelId,
                                  );
                                },
                              ))),
                );
              },
              style: ElevatedButton.styleFrom(
                  primary: MaterialColors.mainColor,
                  elevation: 0,
                  minimumSize: Size(width / 2, 40)),
            ),
          ],
        ),
      ),
    ));
  }
}

class CompButton extends StatelessWidget {
  final int id;
  final int modelId;
  final String startDate;
  final String endDate;
  final String location;
  const CompButton(
      {Key key,
      this.startDate,
      this.endDate,
      this.location,
      this.id,
      this.modelId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(-2, 5),
              blurRadius: 10,
              color: Color(0xFFF0F0F0).withOpacity(0.5),
            )
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: MaterialColors.mainColor,
          ),
        ),
        child: FlatButton(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Ngày bắt đầu: ' +
                      startDate +
                      '\n'
                          'Ngày kết thúc: ' +
                      endDate +
                      '\n'
                          'Địa điểm: ' +
                      location,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              SizedBox(
                width: 30,
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                              create: (_) => AvailibleListViewModel(),
                            ),
                          ],
                          child: FutureBuilder(
                            builder: (context, snapshot) {
                              return AvailibleDetailsPage(
                                modelId: modelId,
                                id: id,
                                startDate: startDate,
                                endDate: endDate,
                                location: location,
                              );
                            },
                          ))),
            );
          },
        ),
      ),
    );
  }
}
