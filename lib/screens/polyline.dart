import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyPolyline extends StatefulWidget {
  const MyPolyline({super.key});

  @override
  State<MyPolyline> createState() => _MyPolylineState();
}

class _MyPolylineState extends State<MyPolyline> {
  Completer<GoogleMapController> _controler = Completer();
  final Set<Marker> _marker = {};
  final Set<Polyline> _polyline = {};
  List<LatLng> position = [
    LatLng(33.665911, 73.070593),
    LatLng(34.034384, 71.537003),
  ];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < position.length; i++) {
      _marker.add(Marker(
          icon: BitmapDescriptor.defaultMarker,
          markerId: MarkerId(i.toString()),
          position: position[i],
          infoWindow: const InfoWindow(
              title: "Really Cool Place", snippet: "5 Star Rating")));
      setState(() {});
    }
    _polyline.add(Polyline(
        polylineId: PolylineId('1'), points: position, color: Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Polyline'),
      ),
      body: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _controler.complete(controller);
          },
          polylines: _polyline,
          markers: _marker,
          initialCameraPosition:
              CameraPosition(target: LatLng(33.665911, 73.070593), zoom: 14)),
    );
  }
}
