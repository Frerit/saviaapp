import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saviaapp/controller/HomeController.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  HomeController controller = Get.put(HomeController());
  final CameraPosition _center = CameraPosition(target: LatLng(6.30206347, -75.54163412), zoom: 14);

  @override
  void initState() {
    getLocationUser();
    super.initState();
  }

  void getLocationUser() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission != LocationPermission.always || permission != LocationPermission.whileInUse) {
        Geolocator.requestPermission().whenComplete(() {
          getPositions();
        });
      } else {
        getPositions();
      }
    } catch (e) {
      printError(info: e);
    }
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
                getLocationUser();
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
            )
          ],
        ),
      ),
    );
  }
}
