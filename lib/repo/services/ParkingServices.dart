import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:parking/data/urls.dart';
import 'package:parking/models/SpotAvailable.dart';
import 'package:parking/models/parking_model.dart';
import 'package:parking/repo/interface/parking_interface.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class ParkingServices with ChangeNotifier implements ParkingInterface {
  @override
  Future<List<Parking>> getAllParkingSpots() async {
    List<Parking> parkingList = [];
    var url = Uri.parse("${Urls.baseUrl}api/v1/parking/all");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      for (var i = 0; i < body.length; i++) {
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

}
