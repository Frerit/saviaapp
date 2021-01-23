import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:saviaapp/common/constant.dart';
import 'package:saviaapp/ui/AcountView.dart';
import 'package:saviaapp/ui/HomeView.dart';

class WelcomeView extends StatefulWidget {

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        color: Colors.white,
        child: Padding(
          padding:  EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text("Bienvenido", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 0),
              FutureBuilder(
                future: FirebaseFirestore.instance.collection("Afiliados").doc(box.read("uuid")).get(),
                builder: (c, AsyncSnapshot snap) => snap.connectionState != ConnectionState.done
                ? Center(child: CircularProgressIndicator())
                : Row(
                  children: [
                    Text('${snap.data["PrimerNombre"]} ${snap.data["PrimerApellido"]}', style: TextStyle(fontSize: 17),),
                    IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Constants.Jade,
                          size: 20.0,
                        ),
                        onPressed: () async {
                          final resul = await Get.to(AcountView());
                          setState(() { });
                        })
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(height: 1, color: Colors.grey),
              SizedBox(height: 10),





              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Estado: "),
                      Text("Regimen: "),
                    ],
                  ),
                  SizedBox(width: 10),
                  FutureBuilder(
                    future: FirebaseFirestore.instance.collection("Afiliaciones").where("Documento", isEqualTo: box.read("userId")).limit(1).get(),
                    builder:(c, AsyncSnapshot snap) {
                      if (snap.connectionState != ConnectionState.done) {
                        return SizedBox();
                      }
                      QuerySnapshot query = snap.data;
                      final data = query.docs.first.data();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data["Estado"]),
                          Text(data["Regimen"]),
                        ],
                      );
                    }
                  )
                ],
              ),
              SizedBox(height: 20),
              Container(height: 1, color: Colors.grey),
              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal:30.0, vertical: 40),
                child: RaisedButton(
                  padding: EdgeInsets.all(15),
                  color: Constants.Claro,
                  onPressed: () {
                    Get.to(HomeView());
                  },
                  textColor: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "CONTINUAR",
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
      ),
    );
  }
}
