import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pimo/module/deprecated/flutter_session/flutter_session.dart';
import 'package:pimo/screens/home_page.dart';
import 'package:pimo/screens/incoming_casting.dart';
import 'package:pimo/screens/model_task.dart';
import 'package:pimo/screens/model_collection.dart';
import 'package:pimo/screens/model_profile.dart';
import 'package:pimo/viewmodels/casting_applies_list_view_model.dart';
import 'package:pimo/viewmodels/casting_browse_list_view_model.dart';
import 'package:pimo/viewmodels/casting_info_list_view_model.dart';
import 'package:pimo/viewmodels/casting_result_list_view_model.dart';
import 'package:pimo/viewmodels/image_collection_project_list_view_model.dart';
import 'package:pimo/viewmodels/model_view_model.dart';
import 'package:pimo/viewmodels/task_list_view_model.dart';
import 'package:provider/provider.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});

  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (tabItem == "Page1")
      child = Page1();
    else if (tabItem == "Page2")
      child = Page2();
    else if (tabItem == "Page3")
      child = Page3();
    else if (tabItem == "Page4")
      child = Page4();
    else if (tabItem == "Page5") child = Page5();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CastingInfoListViewModel()),
        ],
        child: FutureBuilder(
          future: FlutterSession().get('modelId'),
          builder: (context, snapshot) {
            return MainScreen();
          },
        ));

    // return MainScreen();
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CastingBrowseListViewModel()),
          ChangeNotifierProvider(create: (_) => CastingAppliesListViewModel()),
        ],
        child: FutureBuilder(
          future: FlutterSession().get('modelId'),
          builder: (context, snapshot) {
            return IncomingCastingPage();
          },
        ));
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TaskListViewModel()),
          ChangeNotifierProvider(create: (_) => CastingResultListViewModel()),
        ],
        child: FutureBuilder(
          builder: (context, snapshot) {
            // return Container();
            return ModelTaskPage();
          },
        ));
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ImageCollectionProjectListViewModel()),
          // ChangeNotifierProvider(create: (_) => CollectionListViewModel()),
        ],
        child: FutureBuilder(
          future: FlutterSession().get('modelId'),
          builder: (context, snapshot) {
            return ModelCollection(
              modelId: snapshot.data.toString(),
            );
          },
        ));
  }
}

class Page5 extends StatelessWidget {
  const Page5({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ModelViewModel()),
        ],
        child: FutureBuilder(
          future: FlutterSession().get('modelId'),
          builder: (context, snapshot) {
            return ModelProfilePage(
              modelId: snapshot.data,
            );
          },
        ));
  }
}
