import 'package:flutter/material.dart';

class MedicamentosView extends StatefulWidget {
  @override
  _MedicamentosViewState createState() => _MedicamentosViewState();
}

class _MedicamentosViewState extends State<MedicamentosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(''),
      ),
      body: Container(
        child: Center(child: Image.network(
          "http://www.taykaviajes.com.ar/img/cons.jpg"),
          ),
      ),
    );
  }
}