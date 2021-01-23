
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saviaapp/ui/HomeView.dart';

class LoginController extends GetxController {

  var uuid = "".obs;
  TextEditingController usuario = TextEditingController();

  @override
  void onInit() {
    usuario.text = "";
    super.onInit();
  }

  validateUser() {
    if (usuario.text.trim() != "" && usuario.text.isNotEmpty) {
      print(usuario.text);
      FirebaseFirestore.instance.collection("usuarios").doc(usuario.text).get().then((value) {
        if (value.data() != null) {
          print(value);
          uuid.value = value.id;
          Get.offAll(HomeView());
        } else {
          Get.snackbar("Error", "Usuario no registrado");
        }
      }).catchError((error) {
      });
    } else {
      Get.snackbar("Error", "Ducumento errado");
    }
  }
}
