import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:parking/data/urls.dart';
import 'package:parking/models/SpotAvailable.dart';
import 'package:parking/models/parking_model.dart';
import 'package:parking/repo/interface/parking_interface.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class ParkingServices with ChangeNotifier  implements ParkingInterface {


  @override
  Future<List<Parking>> getAllParkingSpots() async{
    List<Parking> parkingList =[];
    print("print the status code -----------hello world----1");
    var url = Uri.parse("${Urls.baseUrl}api/v1/parking/all");
    print("print the status code -----------hello world222----2");
    var response = await http.get(url);
    print("print the status code -----------hello world222---jsjsjj@@@@@@@-"+response.statusCode.toString());
    if(response.statusCode==200) {
      var body = json.decode(response.body);
      for(var i=0; i< body.length; i++){
       parkingList.add(Parking.fromJson(body[i]));
       print("print the status code ---------------"+response.statusCode.toString());
      // print("print the status 2 ---------------"+parkingList[1].name.toString());




      }
      print("print the status code ---------------"+response.statusCode.toString());
      return parkingList;
    }

    else {
      throw Exception('Failed to load data');

    }


  }

  @override
  Future<Parking> saveParkingSpots(Parking saveParking) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<SpotAvailable> bookSpot(int id, bool available) async {


    var url = Uri.parse("${Urls.baseUrl+Urls.baseUrl}parking/updateSpot/$id/$available");
    var response =await  http.put(url);
    SpotAvailable spotAvailable= SpotAvailable();


      if (response.statusCode == 200){
        print(' spot has been updated ----------------success----------------'+response.statusCode.toString());
        
        //var body = jsonDecode(response.body);
        //spotAvailable = SpotAvailable.fromJson(body);
        return spotAvailable;



      }
      else {
        print('Failed to update spot with status code: ');
        // Handle the error appropriately
        throw Exception('Failed to update spot');
      }


      // TODO: implement bookSpot





    }


}