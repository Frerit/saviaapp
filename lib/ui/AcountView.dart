import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saviaapp/common/constant.dart';
import 'package:saviaapp/controller/ProfileController.dart';

class AcountView extends StatefulWidget {
  @override
  _AcountViewState createState() => _AcountViewState();
}

class _AcountViewState extends State<AcountView> {

  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:20.0),
          child: FutureBuilder(
            future: FirebaseFirestore.instance.collection("Afiliados").where("Documento",isEqualTo: "123").get(),
            builder: (context, snap) {
              if (snap.connectionState != ConnectionState.done) {
                return Center(child: CircularProgressIndicator());
              }
              QuerySnapshot query = snap.data;
              controller.changeData(query.docs.first);
              return ListView(
                children: [
                  SizedBox(height: 20),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: controller.firtsName,
                          decoration: InputDecoration(
                              labelText: "Primer nombre",
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: TextFormField(
                          controller: controller.secondName,
                          decoration: InputDecoration(
                              labelText: "Segundo nombre"
                          ),
                        ),
                      )
                    ],
                  ),

                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: controller.surName,
                          decoration: InputDecoration(
                              labelText: "Primer apellido"
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: TextFormField(
                          controller: controller.secondsurName,
                          decoration: InputDecoration(
                              labelText: "Segundo apellido"
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 12,),
                            Text("Tipo documento", style: TextStyle(color: Colors.black54)),
                            SizedBox(height: 6),
                            Obx(() => DropdownButton(
                                isDense: true,
                                isExpanded: true,
                                value: controller.doctype.value,
                                underline: Container(
                                  height: 2,
                                  color: Colors.grey,
                                ),
                                items: [
                                  DropdownMenuItem(
                                    child: Text("RC"),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text("TI"),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                    child: Text("CC"),
                                    value: 3,
                                  ),
                                  DropdownMenuItem(
                                    child: Text("CE"),
                                    value: 4,
                                  ),
                                  DropdownMenuItem(
                                    child: Text("PEP"),
                                    value: 5,
                                  ),
                                ],
                                onChanged: (value) => controller.doctype.value = value,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: TextFormField(
                          controller: controller.document,
                          decoration: InputDecoration(
                              labelText: "Documento"
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: controller.birtDate,
                          decoration: InputDecoration(
                              labelText: "Fecha de Nacimiento"
                          ),
                        ),
                      )
                    ],
                  ),

                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: controller.email,
                          decoration: InputDecoration(
                              labelText: "Correo"
                          ),
                        ),
                      )
                    ],
                  ),

                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: controller.phone,
                          decoration: InputDecoration(
                              labelText: "Fijo"
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: TextFormField(
                          controller: controller.cellphone,
                          decoration: InputDecoration(
                              labelText: "Celular"
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: controller.address,
                          decoration: InputDecoration(
                              labelText: "Direccion"
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:30.0, vertical: 40),
                    child: RaisedButton(
                      padding: EdgeInsets.all(15),
                      color: Constants.Claro,
                      onPressed: () => controller.saveProfileUser(),
                      textColor: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "GUARDAR",
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
              );
            },
          ),
        ),
      ),
    );
  }
}
