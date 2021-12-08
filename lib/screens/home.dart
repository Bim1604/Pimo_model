import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pimo/widgets/tab_navigation.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Model Booking',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //List page Routers
  String _currentPage = "Page1";
  List<String> pageKeys = ["Page1", "Page2", "Page3", "Page4", "Page5"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
    "Page4": GlobalKey<NavigatorState>(),
    "Page5": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Page1") {
            _selectTab("Page1", 1);
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator("Page1"),
          _buildOffstageNavigator("Page2"),
          _buildOffstageNavigator("Page3"),
          _buildOffstageNavigator("Page4"),
          _buildOffstageNavigator("Page5")
        ]),
        bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          backgroundColor: Colors.transparent,
          color: Color.fromRGBO(246, 156, 184, 1),
          index: _selectedIndex,
          items: <Widget>[
            SizedBox(
              height: 38,
              child: Column(
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  Center(
                    child: Text(
                      'Trang chủ',
                      style: TextStyle(fontSize: 10),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 38,
              child: Column(
                children: [
                  Icon(
                    Icons.schedule,
                    color: Colors.black,
                  ),
                  Center(
                    child: Text(
                      'Chiến dịch',
                      style: TextStyle(fontSize: 10),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 38,
              child: Column(
                children: [
                  Icon(
                    Icons.list_alt,
                    color: Colors.black,
                  ),
                  Center(
                    child: Text(
                      'Nhiệm vụ',
                      style: TextStyle(fontSize: 10),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 38,
              child: Column(
                children: [
                  Icon(
                    Icons.image,
                    color: Colors.black,
                  ),
                  Center(
                    child: Text(
                      'Ảnh',
                      style: TextStyle(fontSize: 10),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 38,
              child: Column(
                children: [
                  Icon(
                    Icons.account_circle,
                    color: Colors.black,
                  ),
                  Center(
                    child: Text(
                      'Thông tin',
                      style: TextStyle(fontSize: 10),
                    ),
                  )
                ],
              ),
            ),
          ],
          onTap: (index) {
            _selectTab(pageKeys[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
