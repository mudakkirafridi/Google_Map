import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition kGoogleMap =
      const CameraPosition(target: LatLng(34.1035, 71.1598), zoom: 17);

  List<Marker> _marker = [];
  final List<Marker> _list = [
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(34.1035, 71.1598),
        infoWindow: InfoWindow(title: 'Mudakir College'))
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
          initialCameraPosition: kGoogleMap,
          markers: Set<Marker>.of(_marker),
          mapType: MapType.hybrid,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(
                const CameraPosition(
                    target: LatLng(34.0706, 71.2176), zoom: 15)));
            setState(() {});
          },
          child: const Icon(Icons.location_on),
        ));
  }
}
