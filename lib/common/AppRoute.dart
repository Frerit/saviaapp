import 'package:get/get.dart';
import 'package:saviaapp/ui/LoginView.dart';
import 'package:saviaapp/ui/Splash.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => LoginView())
  ];
}