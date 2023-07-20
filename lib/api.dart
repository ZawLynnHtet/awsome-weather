// import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

Future<Map> cityCall(String city) async {
  String apiUrl =
      "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=32ad84d2a41f15df8af1a765bb38c530&units=metric";
  return apiCall(apiUrl);
}

Future<Map> latLonCall(Position location) async {
  double lat = location.altitude;
  double lon = location.longitude;
  String apiUrl =
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=32ad84d2a41f15df8af1a765bb38c530&units=metric";
  return apiCall(apiUrl);
}

Future<Map> apiCall(String apiUrl) async {
  final url = Uri.parse(apiUrl);
  var response = await http.get(url);
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    return await convert.jsonDecode(response.body) as Map<String, dynamic>;
  } else {
    throw ("Something went wrong ${response.statusCode}");
  }
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  // if (!serviceEnabled) {
  //   return Future.error('Location services are disabled.');
  // }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}
