import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {

  GoogleMapController mapController;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rx<CameraPosition> initialPosition = CameraPosition(target: LatLng(6.30206347, -75.54163412), zoom: 14).obs;
  RxList<Marker> markers = RxList<Marker>();
  RxBool modalInfo = false.obs;

  void onMapCreatedFunc(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void onInit() {
    getLocations();
    super.onInit();
  }

  void getLocations() async {
    final markerIcon = await getBytesFromAsset('assets/hospital.png', 80);

    firestore.collection("ips").get().then((value) {
          if ( value.docs.isNotEmpty) {
            value.docs.forEach((element) {
              final ipsModel = element.data();
              GeoPoint position = ipsModel["cordenadas"];
              markers.add(
                  Marker(
                    onTap: () => enableModalInfo(ipsModel["nombre"]),
                    markerId: MarkerId(element.id),
                    icon: BitmapDescriptor.fromBytes(markerIcon),
                    position: LatLng(position.latitude, position.longitude),
                  )
                );
            });
          }
      });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png)).buffer.asUint8List();
  }

  void enableModalInfo(String units) {
    print(units);
    modalInfo.value = true;
  }
}