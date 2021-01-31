import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saviaapp/common/AppRoute.dart';
import 'package:saviaapp/ui/Splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<FirebaseApp> _initialization;

  @override
  void initState() {
    _initialization = Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.teal,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: "/",
            getPages: AppRoutes.routes,
          );
        }
        return Splash();
      },
    );

  }
}
