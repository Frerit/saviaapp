import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saviaapp/common/constant.dart';
import 'package:saviaapp/ui/AcountView.dart';
import 'package:saviaapp/ui/LoginView.dart';
import 'package:saviaapp/ui/MedicamentosView.dart';
import 'package:saviaapp/ui/ScheduleView.dart';
import 'package:saviaapp/ui/WelcomeView.dart';

class DraweMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(22),
                bottomRight: Radius.circular(22),
              )
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 66),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: MaterialButton(
                      onPressed: () => Navigator.pop(context),
                      color: Colors.white,
                      textColor: Colors.black,
                      child: Hero(
                          tag: "menu1",
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Icon(
                                Icons.menu,
                                color: Constants.Jade,
                                size: 30,
                              ),
                          )
                      ),
                      padding: EdgeInsets.all(10),
                      shape: CircleBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(WelcomeView());
                    },
                    title: Text("Inicio", style: TextStyle(color: Constants.Jade, fontWeight: FontWeight.w800)),
                  ),
                  ListTile(
                    title: Text("Accesos", style: TextStyle(color: Constants.Jade, fontWeight: FontWeight.w800)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context); 
                                  Get.to(ScheduleView());},
                                child: Padding(
                                  padding: EdgeInsets.symmetric( vertical: 7.0),
                                  child: Text("Agendar cita medica", textAlign: TextAlign.left, style: TextStyle(color: Constants.Jade, fontWeight: FontWeight.w400)),
                                )),
                            InkWell( onTap: () {
                                  Navigator.pop(context); 
                                  Get.to(ScheduleView());},
                                child: Padding(
                                  padding: EdgeInsets.symmetric( vertical: 7.0),
                                  child: Text("Agendar cita tramites", textAlign: TextAlign.left, style: TextStyle(color: Constants.Jade, fontWeight: FontWeight.w400)),
                                )),
                            InkWell( onTap: () {
                                  Navigator.pop(context);  
                                  Get.to(MedicamentosView());
                                  },
                                child: Padding(
                                  padding: EdgeInsets.symmetric( vertical: 7.0),
                                  child: Text("Consulta medicamentos", textAlign: TextAlign.left, style: TextStyle(color: Constants.Jade, fontWeight: FontWeight.w400)),
                                )),
                            InkWell( onTap: () {
                                  Navigator.pop(context);
                                  Get.to(MedicamentosView());
                                  },
                                child: Padding(
                                  padding: EdgeInsets.symmetric( vertical: 7.0),
                                  child: Text("Consultar Autorizaciones", textAlign: TextAlign.left, style: TextStyle(color: Constants.Jade, fontWeight: FontWeight.w400)),
                                )),

                            InkWell( onTap: () {
                                  Navigator.pop(context);
                                  Get.to(MedicamentosView());
                                  },
                                child: Padding(
                                  padding: EdgeInsets.symmetric( vertical: 7.0),
                                  child: Text("Quejas y reclamos (PQRSF)", textAlign: TextAlign.left, style: TextStyle(color:  Constants.Jade, fontWeight: FontWeight.w400)),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () => Get.to(AcountView()),
                    title: Text("Perfil", style: TextStyle(color: Constants.Jade, fontWeight: FontWeight.w800)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40),
                    child:  Row(
                      children: [
                        Column(
                          children: [
                             InkWell(
                                onTap: () {
                                  Navigator.pop(context); 
                                  Get.to(AcountView());
                                  },
                                child: Padding(
                                  padding: EdgeInsets.symmetric( vertical: 7.0),
                                  child: Text("Actualizar datos", textAlign: TextAlign.left, style: TextStyle(color:  Constants.Jade, fontWeight: FontWeight.w400)),
                                )),
                             InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  Get.to(LoginView()); 
                                  },
                                child: Padding(
                                  padding: EdgeInsets.symmetric( vertical: 7.0, horizontal: 0),
                                  child: Text("Cerrar Session   ", textAlign: TextAlign.left, style: TextStyle(color:  Constants.Jade, fontWeight: FontWeight.w400)),
                                )),
                          ],
                        )
                      ],
                    )
                   ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
