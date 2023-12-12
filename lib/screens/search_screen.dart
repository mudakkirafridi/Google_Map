import 'dart:convert';
import 'dart:html';

import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '12345';
  List<dynamic> _placesList = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(searchController.text);
  }

  void getSuggestion(String input) async {
    String API_KEY = 'AIzaSyDUpkW2Cixeg33umfD87s9CYkzsSyC3jXI';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        "$baseURL?input=$input&key=$API_KEY&sessiontoken=$_sessionToken";

    var myresponse = await http.get(Uri.parse(request));
    if (myresponse.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(myresponse.body.toString())['predictions'];
      });
    } else {
      throw Exception('Failed To Load Data ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Search Places',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search Places",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.black12)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.black12)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.black12)),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: _placesList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          List<Location> location = await locationFromAddress(
                              _placesList[index]['description']);
                          print(location.last.latitude);
                          print(location.last.longitude);
                        },
                        title: Text(_placesList[index]['description']),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
