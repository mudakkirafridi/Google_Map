import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyPolygon extends StatefulWidget {
  const MyPolygon({super.key});

  @override
  State<MyPolygon> createState() => _MyPolygonState();
}

class _MyPolygonState extends State<MyPolygon> {
  Completer<GoogleMapController> _completer = Completer();
  final Set<Polygon> _polygon = HashSet<Polygon>();
  List<LatLng> points = [
    LatLng(33.660329, 73.085595),
    LatLng(33.704039, 72.891961),
    LatLng(33.732881, 73.043366),
    LatLng(33.660329, 73.085595),
  ];

  @override
  void initState() {
    super.initState();
    _polygon.add(
      Polygon(
          polygonId: PolygonId('1'),
          points: points,
          fillColor: Colors.yellow.withOpacity(.3),
          geodesic: true,
          strokeWidth: 3,
          strokeColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MY Polygon')),
      body: GoogleMap(
        mapType: MapType.normal,
        polygons: _polygon,
        initialCameraPosition:
            CameraPosition(target: LatLng(33.660329, 73.085595), zoom: 14),
        onMapCreated: (GoogleMapController controller) {
          _completer.complete(controller);
        },
      ),
    );
  }
}
