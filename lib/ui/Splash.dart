import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saviaapp/controller/SplashController.dart';
import 'package:saviaapp/ui/LoginView.dart';

class Splash extends StatelessWidget {

  SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          child: Image.network(
              "https://intrasavia.saviasaludeps.com/intrasavia/resources/images/logo_savia_formulario.png",
             fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
