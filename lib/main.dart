import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pimo/screens/authentication.dart';
import 'package:pimo/screens/home.dart';
import 'package:pimo/screens/onboarding.dart';
import 'package:pimo/utils/google_sign_in.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
          title: "Model Booking",
          debugShowCheckedModeBanner: false,
          initialRoute: "/onboarding",
          routes: <String, WidgetBuilder>{
            "/onboarding": (BuildContext context) => new Onboarding(),
            "/home": (BuildContext context) => new Home(),
            "/authentication": (BuildContext context) =>
                new HomeAuthentication(),
          }),
    );
  }
}
