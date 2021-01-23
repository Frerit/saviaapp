import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saviaapp/common/constant.dart';
import 'package:saviaapp/controller/LoginController.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: Image.network(
                "https://intrasavia.saviasaludeps.com/intrasavia/resources/images/logo_savia_formulario.png",
                fit: BoxFit.contain,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
               child: TextFormField(
                 controller: controller.usuario,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)
                      ),
                      hintText: "Ingrese Cedula"
                  ),
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(25),
                  ],
                ),
             ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal:30.0, vertical: 40),
              child: RaisedButton(
                padding: EdgeInsets.all(15),
                color: Constants.Claro,
                onPressed: () => controller.validateUser(),
                textColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "INGRESAR",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
