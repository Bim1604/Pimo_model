import 'package:flutter/material.dart';

import 'package:pimo/constants/Theme.dart';
import 'package:pimo/screens/model_collection_bodypart.dart';
import 'package:pimo/screens/model_collection_project.dart';
import 'package:pimo/viewmodels/collection_bodypart_list_view_model.dart';
import 'package:pimo/viewmodels/collection_project_list_view_model.dart';
import 'package:provider/provider.dart';

class ModelCollection extends StatefulWidget {
  final String modelId;
  const ModelCollection({Key key, this.modelId}) : super(key: key);

  @override
  _ModelImagePageState createState() => _ModelImagePageState();
}

class _ModelImagePageState extends State<ModelCollection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Hình ảnh',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(-2, 5),
                        blurRadius: 10,
                        color: MaterialColors.mainColor.withOpacity(0.5),
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: MaterialColors.mainColor,
                    ),
                  ),
                  child: FlatButton(
                    padding:
                        const EdgeInsets.only(left: 30, top: 15, bottom: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.white,
                    // onLongPress: () async {
                    //   await _showDeleteDialog(context, collection.id);
                    // },
                    onPressed: () {
                      (Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MultiProvider(
                                    providers: [
                                      ChangeNotifierProvider(
                                          create: (_) =>
                                              ListCollectionBodyPartListViewModel()),
                                    ],
                                    child: FutureBuilder(
                                      builder: (context, snapshot) {
                                        print(snapshot.data);
                                        return const ModelCollectionBodyPart();
                                      },
                                    ))),
                      ));
                    },
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text(
                            ('Bộ sưu tập cá nhân'),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Icon(
                          Icons.navigate_next,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-2, 5),
                        blurRadius: 10,
                        color: MaterialColors.mainColor.withOpacity(0.5),
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: MaterialColors.mainColor,
                    ),
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.only(left: 30, top: 15, bottom: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.white,
                    // onLongPress: () async {
                    //   await _showDeleteDialog(context, collection.id);
                    // },
                    onPressed: () {
                      (Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MultiProvider(
                                    providers: [
                                      ChangeNotifierProvider(
                                          create: (_) =>
                                              ListCollectionProjectListViewModel()),
                                    ],
                                    child: FutureBuilder(
                                      builder: (context, snapshot) {
                                        return const ModelCollectionProject();
                                      },
                                    ))),
                      ));
                    },
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text(
                            ('Bộ sưu tập dự án'),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Icon(
                          Icons.navigate_next,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
