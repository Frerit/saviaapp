import 'package:flutter/material.dart';

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
              color: Colors.black,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.menu,
                          size: 30,
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                      shape: CircleBorder(),
                    ),
                  ),
                  ListTile(
                    title: Text("Inicio", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                  ),
                  ListTile(
                    title: Text("Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                  ),
                  ListTile(
                    title: Text("Perfil", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
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
