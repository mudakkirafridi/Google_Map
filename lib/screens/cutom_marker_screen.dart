import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyInfoWindow extends StatefulWidget {
  const MyInfoWindow({super.key});

  @override
  State<MyInfoWindow> createState() => _CustomInfoWindowState();
}

class _CustomInfoWindowState extends State<MyInfoWindow> {
  CustomInfoWindowController _infoWindowController =
      CustomInfoWindowController();

  final List<Marker> _markerList = [];
  final List<LatLng> marker = [
    LatLng(33.6941, 729734),
    LatLng(33.7808, 9682),
    LatLng(33.6992, 9744),
    LatLng(33.6939, 9771),
    LatLng(33.6910, 9807),
    LatLng(33.7036, 9785)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  load() {
    for (int index = 0; index < marker.length; index++) {
      _markerList.add(Marker(
          markerId: MarkerId(index.toString()),
          icon: BitmapDescriptor.defaultMarker,
          position: marker[index],
          onTap: () {
            _infoWindowController.addInfoWindow!(
                Container(
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage('')),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 300,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: Colors.green)),
                      )
                    ],
                  ),
                ),
                marker[index]);
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Custom Info Window')),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: LatLng(33.6941, 729734)),
              markers: Set<Marker>.of(_markerList),
              onTap: (position) {
                _infoWindowController.hideInfoWindow!();
              },
              onMapCreated: (GoogleMapController controller) {
                _infoWindowController.googleMapController = controller;
              },
            ),
            CustomInfoWindow(controller: _infoWindowController)
          ],
        ));
  }
}
