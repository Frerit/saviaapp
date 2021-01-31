
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:saviaapp/common/constant.dart';
import 'package:saviaapp/ui/WelcomeView.dart';

class LoginController extends GetxController {

  var uuid = "".obs;
  TextEditingController usuario = TextEditingController();
  final box = GetStorage();

  @override
  void onInit() {
    usuario.text = "";
    super.onInit();
  }

  validateUser() {
    if (usuario.text.trim() != "" && usuario.text.isNotEmpty) {
      print(usuario.text);
      FirebaseFirestore.instance.collection("Afiliados").where("Documento", isEqualTo: usuario.text).get().then((value) {
        if (value.docs.first != null) {
          final user = value.docs.first;
          print(user.id);
          uuid.value = user.id;
          box.write("userId", usuario.text);
          box.write("uuid", user.id);
          Get.offAll(WelcomeView());
        } else {
          Get.snackbar("Error", "Usuario no registrado",
           snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Constants.Claro,
          margin: EdgeInsets.all(20));
        }
      }).catchError((error) {
        Get.snackbar("Error", "Usuario no registrado",
         snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Constants.Claro,
          margin: EdgeInsets.all(20));
      });
    } else {
      Get.snackbar("Error", "Ducumento errado",
       snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Constants.Claro,
          margin: EdgeInsets.all(20));
    }
  }
}
