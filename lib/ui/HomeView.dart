import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saviaapp/common/DrawerMenu.dart';
import 'package:saviaapp/common/constant.dart';
import 'package:saviaapp/controller/HomeController.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  HomeController controller = Get.put(HomeController());
  final CameraPosition _center = CameraPosition(target: LatLng(6.30206347, -75.54163412), zoom: 14);
  final GlobalKey<ScaffoldState> _homeKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    _determinePosition();
    super.initState();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    } 
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    } 
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getPositions() async {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium, forceAndroidLocationManager: true).then((Position position) {
      controller.initialPosition.value = CameraPosition(target: LatLng(position.latitude, position.longitude),zoom: 12);
      _updateCamera();
    });
  }

  Future<void> _updateCamera() async {
    if (controller.mapController != null) {
      await controller.mapController.animateCamera(CameraUpdate.newCameraPosition(controller.initialPosition.value));
      controller.onMapCreatedFunc(controller.mapController);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _homeKey,
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: DraweMenu()
      ),
      body: Container(
        child: Stack(
          children: [
            FutureBuilder(
              future: Geolocator.requestPermission(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }  
                if (snapshot.data != LocationPermission.whileInUse){
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Request location permission", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),),
                          SizedBox(height: 10),
                          Text("Access to the device\'s location has been denied, please request permissions before continuing", textAlign: TextAlign.center,),
                          SizedBox(height: 10),
                          RaisedButton(
                            child: const Text('Request permission'),
                            onPressed: () => Geolocator.openLocationSettings()
                                .then((status) => print("")),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                _determinePosition();
                return Obx(
                  () => GoogleMap(
                        mapType: MapType.normal,
                        markers: controller.markers.toSet(),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        initialCameraPosition: controller.initialPosition.value ?? _center,
                        onMapCreated: controller.onMapCreatedFunc
                      )
                   );
              }
            ),

            Positioned(
              top: 70,
              left: 0,
              child: MaterialButton(
                onPressed: () => _homeKey.currentState.openDrawer(),
                color: Colors.white,
                textColor: Colors.black,
                child: Hero(
                    tag: "menu",
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
          ],
        ),
      ),
    );
  }
}
