import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';

class LatLngConToAdress extends StatefulWidget {
  const LatLngConToAdress({super.key});

  @override
  State<LatLngConToAdress> createState() => _LatLngConToAdressState();
}

class _LatLngConToAdressState extends State<LatLngConToAdress> {
  String myAdress = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lat Lng Convert To Adress'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(myAdress),
          ElevatedButton(
              onPressed: () async {
                final cordinate = Coordinates(34.0706, 71.2176);
                var address = await Geocoder.local
                    .findAddressesFromCoordinates(cordinate);
                var first = address.first;
                setState(() {
                  myAdress = first.featureName.toString();
                });
              },
              child: const Text('Convert'))
        ],
      ),
    );
  }
}
