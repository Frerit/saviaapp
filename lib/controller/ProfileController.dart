import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:saviaapp/common/constant.dart';

class ProfileController extends GetxController {

  var doctype = 3.obs;

  final box = GetStorage();

  TextEditingController firtsName = TextEditingController();
  TextEditingController secondName = TextEditingController();
  TextEditingController surName = TextEditingController();
  TextEditingController secondsurName = TextEditingController();
  TextEditingController documenType = TextEditingController();
  TextEditingController document = TextEditingController();
  TextEditingController birtDate = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cellphone = TextEditingController();


  changeData(DocumentSnapshot data) {
    firtsName.text = data["PrimerNombre"];
    secondName.text = data["SegundoNombre"];
    surName.text = data["PrimerApellido"];
    secondsurName.text = data["SegundoApellido"];
    doctype.value = getDocumentType(data["TipoDocumento"]);
    document.text = data["Documento"];
    birtDate.text = data["FechaNacimiento"];
    email.text = data["Email"];
    address.text = data["Direccion"];
    phone.text = data["Telefono"];
    cellphone.text = data["Movil"];
  }

  int getDocumentType(String type) {
    switch (type) {
      case "RC": return 1;
      case "TI": return 2;
      case "CC": return 3;
      case "CE": return 4;
      case "PEP":return 5;
    }
  }

  String getDocumentString(int type) {
    switch (type) {
      case 1: return "RC";
      case 2: return "TI";
      case 3: return "CC";
      case 4: return "CE";
      case 5: return "PEP";
    }
  }

  saveProfileUser() {
      FirebaseFirestore.instance.collection("Afiliados").doc(box.read("uuid"))
          .update({
            "PrimerNombre" : firtsName.text,
            "SegundoNombre" : secondName.text,
            "PrimerApellido" : surName.text,
            "SegundoApellido" : secondsurName.text,
            "TipoDocumento" : getDocumentString(doctype.value),
            "Documento" : document.text,
            "FechaNacimiento" : birtDate.text,
            "Email" : email.text,
            "Direccion" : address.text,
            "Telefono" : phone.text,
            "Movil" :cellphone.text
      }).then((value) => Get.snackbar(
          "!Exito¡",
          "Estos datos han sido actualizados",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Constants.Claro,
          margin: EdgeInsets.all(20)
      ));
  }



}