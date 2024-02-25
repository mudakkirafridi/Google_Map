import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyStylingMap extends StatefulWidget {
  const MyStylingMap({super.key});

  @override
  State<MyStylingMap> createState() => _MyStylingMapState();
}

class _MyStylingMapState extends State<MyStylingMap> {
  Completer<GoogleMapController> _controller = Completer();
  String mapTheme = '';
  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/googlemap_styling.json')
        .then((value) {
      mapTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Styling'),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                        onTap: () {
                          _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString('assets/googlemap_silver.json')
                                .then((string) {
                              value.setMapStyle(string);
                            });
                          });
                        },
                        child: const Text('Silver')),
                    PopupMenuItem(
                        onTap: () {
                          _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString('assets/googlemap_retro.json')
                                .then((string) {
                              value.setMapStyle(string);
                            });
                          });
                        },
                        child: const Text('Retro')),
                    PopupMenuItem(
                        onTap: () {
                          _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString('assets/googlemap_styling.json')
                                .then((string) {
                              value.setMapStyle(string);
                            });
                          });
                        },
                        child: const Text('Night'))
                  ])
        ],
      ),
      // remember that mapType properties not allowed with google map styling
      body: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(mapTheme);
            _controller.complete(controller);
          },
          initialCameraPosition:
              CameraPosition(target: LatLng(33.665911, 73.070593))),
    );
  }
}
