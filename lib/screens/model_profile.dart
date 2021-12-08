import 'package:flutter/material.dart';
import 'package:pimo/screens/availiable.dart';
import 'package:pimo/screens/project.dart';
import 'package:pimo/screens/update_profile.dart';
import 'package:pimo/utils/google_sign_in.dart';
import 'package:pimo/viewmodels/body_list_view_model.dart';
import 'package:pimo/viewmodels/model_availiable_model.dart';
import 'package:pimo/viewmodels/model_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pimo/constants/Theme.dart';
import 'avatar_page.dart';
import 'measure_template.dart';
import 'onboarding.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ModelProfilePage extends StatefulWidget {
  final int modelId;
  const ModelProfilePage({Key key, this.modelId}) : super(key: key);

  @override
  _ModelProfilePageState createState() => _ModelProfilePageState();
}

class _ModelProfilePageState extends State<ModelProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            body: FutureBuilder<ModelViewModel>(
              future: Provider.of<ModelViewModel>(context, listen: false)
                  .getModel(widget.modelId),
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
                    return Consumer<ModelViewModel>(
                        builder: (ctx, data, child) => Center(
                              child: modelBtn(
                                context: ctx,
                                modelDetail: data,
                              ),
                            ));
                  } else {
                    return Text('Lỗi');
                  }
                }
              },
            ),
          )),
    );
  }

  Widget modelBtn({BuildContext context, ModelViewModel modelDetail}) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              'Tài Khoản',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Stack(
          children: [
            Center(
                child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-2, 5),
                      blurRadius: 10,
                      color: MaterialColors.mainColor.withOpacity(0.3),
                    )
                  ],
                  borderRadius: BorderRadius.circular(80),
                  image: DecorationImage(
                      image: NetworkImage(modelDetail.avatar ?? ''),
                      fit: BoxFit.cover)),
            )),
            Positioned(
                bottom: 5,
                right: 125,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CameraWidget(modelId: modelDetail.id),
                        ));
                  },
                  child: ClipOval(
                      child: Container(
                          padding: EdgeInsets.all(3),
                          color: Colors.white,
                          child: ClipOval(
                              child: Container(
                            padding: EdgeInsets.all(5),
                            color: Colors.black,
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 15,
                            ),
                          )))),
                )),
          ],
        ),
        Container(
          width: 50,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  modelDetail.name ?? '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RawMaterialButton(
                      onPressed: () {},
                      elevation: 4.0,
                      fillColor: MaterialColors.socialFacebook,
                      child: const Icon(FontAwesomeIcons.facebook,
                          size: 24.0, color: Colors.white),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                    RawMaterialButton(
                      onPressed: () {},
                      elevation: 4.0,
                      fillColor: MaterialColors.socialTwitter,
                      child: const Icon(FontAwesomeIcons.twitter,
                          size: 24.0, color: Colors.white),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                    RawMaterialButton(
                      onPressed: () {},
                      elevation: 4.0,
                      fillColor: MaterialColors.socialDribbble,
                      child: const Icon(FontAwesomeIcons.instagram,
                          size: 24.0, color: Colors.white),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
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
                      // width: 2,
                    ),
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Color(0xFFF0F0F0),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ChangeNotifierProvider<ModelViewModel>.value(
                                  value: modelDetail,
                                  child: UpdateModelProfilePage(
                                    modelId: widget.modelId,
                                  ))));
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.supervised_user_circle_sharp,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            'Thông tin cá nhân',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
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
                      // width: 2,
                    ),
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Color(0xFFF0F0F0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MultiProvider(
                                    providers: [
                                      ChangeNotifierProvider(
                                        create: (_) => BodyPartListViewModel(),
                                      ),
                                    ],
                                    child: FutureBuilder(
                                      builder: (context, snapshot) {
                                        return MeasureTemplatePage(
                                          modelId: widget.modelId,
                                        );
                                      },
                                    ))),
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.straighten,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            'Thông tin chi tiết',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
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
                      // width: 2,
                    ),
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Color(0xFFF0F0F0),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ChangeNotifierProvider<ModelViewModel>.value(
                                  value: modelDetail, child: ProjectPage())));
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.all_inbox,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            'Dự án của bạn',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
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
                    padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Color(0xFFF0F0F0),
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
                                        return AvailiableTemplatePage(
                                          modelId: widget.modelId,
                                        );
                                      },
                                    ))),
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.upcoming_outlined,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            'Lịch trình sắp tới',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
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
                    padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Color(0xFFF0F0F0),
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.logout();
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacement(MaterialPageRoute(
                              builder: (context) => MultiProvider(providers: [
                                    ChangeNotifierProvider(
                                      create: (_) => GoogleSignInProvider(),
                                    ),
                                  ], child: Onboarding())));
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.logout,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            'Đăng xuất',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
