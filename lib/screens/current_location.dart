import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition cameraPosition =
      CameraPosition(target: LatLng(34.1035, 71.1598), zoom: 17);

  List<Marker> _list = [];
  List<Marker> myMarker = [
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(34.1035, 71.1598),
        infoWindow: InfoWindow(title: 'My Location'))
  ];

  @override
  void initState() {
    super.initState();
    _list.addAll(myMarker);
  }

  loadData() {
    getUserLocation().then((value) async {
      _list.add(Marker(
          markerId: const MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: 'my location')));

      CameraPosition targetPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom: 17);
      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(targetPosition));
      setState(() {});
    });
  }

  Future<Position> getUserLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print(error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map tutorial'),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: cameraPosition,
        markers: Set<Marker>.of(_list),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          loadData();
        },
        child: const Icon(Icons.my_location_outlined),
      ),
    );
  }
}
