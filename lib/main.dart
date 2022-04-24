import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pimo/login/view_models/authentication.dart';
import 'package:pimo/screens/home.dart';
import 'package:pimo/login/view/onboarding.dart';
import 'package:pimo/login/view_models/google_sign_in.dart';
import 'package:pimo/screens/signin.dart';
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
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
          title: "Model Booking",
          debugShowCheckedModeBanner: false,
          initialRoute: "/onboarding",
          routes: <String, WidgetBuilder>{
            "/onboarding": (BuildContext context) => const Onboarding(),
            "/home": (BuildContext context) => Home(),
            "/authentication": (BuildContext context) =>
                const HomeAuthentication(),
            "/signIn": (BuildContext context) => const SignIn(),
          }),
    );
  }
}
