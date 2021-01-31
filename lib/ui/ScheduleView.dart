import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:saviaapp/common/constant.dart';

class ScheduleView extends StatefulWidget {
  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {

  List<String> _locations = ['Medicina General', 'Odontologia', 'Laboratorio Basico', 'Rayos X', 'PYP']; // Option 2
  String _selectedLocation; // Option 2
  DateTime _currentDate = DateTime(2021, 2, 3);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Agendar Cita'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: DropdownButton(
                isExpanded: true,
                hint: Text('Seleccione tipo de cita'), // Not necessary for Option 1
                value: _selectedLocation,
                onChanged: (newValue) {
                  setState(() {
                    _selectedLocation = newValue;
                  });
                },
                items: _locations.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
              ),
            ),
            Container(
              child: CalendarCarousel(
                onDayPressed: (DateTime date, List<Event> events) {
                  this.setState(() => _currentDate = date);
                },
                weekendTextStyle: TextStyle(
                  color: Constants.Jade,
                ), 
                selectedDayButtonColor: Constants.Jade,
                selectedDateTime: _currentDate,
                 weekFormat: false,
                 height: 400.0,
              )
            ),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 20),
              child: TextField(
               keyboardType: TextInputType.datetime,
                decoration: InputDecoration( 
                  hintText: "Hora"
                ),
              ), 
              ),

           Padding(
              padding: const EdgeInsets.symmetric(horizontal:30.0, vertical: 40),
              child: RaisedButton(
                padding: EdgeInsets.all(15),
                color: Constants.Claro,
                onPressed: () {
                  Get.snackbar(
                    "Cita agendada", "su cita ha sido agendada correctamente",
                     snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Constants.Claro,
                    margin: EdgeInsets.all(20)); 
                  Timer(Duration(seconds: 3), () => Navigator.pop(context));  
                },
                textColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Agendar",
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