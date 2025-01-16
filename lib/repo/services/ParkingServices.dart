import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:parking/data/urls.dart';
import 'package:parking/models/SpotAvailable.dart';
import 'package:parking/models/parking_model.dart';
import 'package:parking/repo/interface/parking_interface.dart';
import 'package:http/http.dart' as http;


class ParkingServices with ChangeNotifier implements ParkingInterface {
  @override
  Future<List<Parking>> getAllParkingSpots() async {
    //try//catch to be implemented
    List<Parking> parkingList = [];
    var url = Uri.parse("${Urls.baseUrl}api/v1/parking/all");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      for (int i = 0; i < body.length; i++) {
        parkingList.add(Parking.fromJson(body[i]));

      }
      print("all Parking Spots succeded ---------------" +
          response.statusCode.toString());
      return parkingList;
    } else {
      throw Exception('Failed to load data for all parking spots------'+response.statusCode.toString());
    }
  }

  @override
  Future<Parking> saveParkingSpots(Parking saveParking) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<SpotAvailable> bookSpot(int userId, SpotAvailable spotAvailable) async {

    var url = Uri.parse("${Urls.baseUrl + Urls.apiV}parking/updateSpot/$userId");


    var response = await http.put(
      url,
   headers:{'Content-Type': 'application/json'},
      body: jsonEncode(spotAvailable));


    if (response.statusCode == 200) {
      print('Spot has been updated successfully: ' + response.statusCode.toString());
      return spotAvailable;
    } else {
      // Handle any other status code as a failure
      print('Failed to update spot with status code: ' + response.statusCode.toString());
      throw Exception('Failed to update spot: ' + response.statusCode.toString());
    }


    // TODO: implement bookSpot
  }


  @override
  Future<List<Map<String, dynamic>>> getPublicSpots(LatLng latLng) async {
    https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=60.38967507959564, 5.33736912404336&radius=500&type=parking&key=apikey
    var url = Uri.parse("${Urls.googleMapAPi}=${latLng.latitude},${latLng.longitude}&radius=500&type=parking&key=${Urls.apiKey}");
    final response =await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<Map<String, dynamic>> parkingSpots = [];

      for (var result in jsonResponse['results']) {
        parkingSpots.add({
          'name': result['name'],
          'address': result['formatted_address'],
          'lat': result['geometry']['location']['lat'],
          'lng': result['geometry']['location']['lng'],
        });
      }
      return parkingSpots;
    }
    //
    else {
      throw Exception('Failed to load parking data');
    }}

}
