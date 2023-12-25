import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "dart:typed_data";
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({super.key});

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {
  Uint8List? markerImage;
  Completer<GoogleMapController> googleMapContoller = Completer();
  static const CameraPosition cameraPosition =
      CameraPosition(target: LatLng(33.6941, 72.9734), zoom: 14);
  List<String> images = [
    "assets/images/car.png",
    "assets/images/car1.png",
    "assets/images/car3.png",
  ];
  List<Marker> _markerList = [];
  List<LatLng> latLngList = [
    LatLng(33.6941, 72.9734),
    LatLng(33.7008, 72.9682),
    LatLng(33.6992, 72.9744)
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    for (var index = 0; index < latLngList.length; index++) {
      final Uint8List markerIcon = await getBytesFromAssets(images[index], 100);
      _markerList.add(Marker(
          markerId: MarkerId(index.toString()),
          position: latLngList[index],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow:
              InfoWindow(title: 'this is title marker ${index.toString()}')));
    }
  }

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Marker"),
      ),
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        markers: Set.of(_markerList),
        onMapCreated: (GoogleMapController controller) {
          googleMapContoller.complete(controller);
        },
      ),
    );
  }
}
