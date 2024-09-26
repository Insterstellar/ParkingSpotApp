import 'dart:convert';


import 'package:parking/data/urls.dart';
import 'package:parking/models/SpotAvailable.dart';
import 'package:parking/models/reveiw_parking.dart';
import 'package:parking/models/user_parking.dart';
import 'package:parking/repo/interface/userParkingInterface.dart';
import 'package:http/http.dart' as http;

import '../../models/parking_model.dart';

class UserParkingService implements UserParkingInterface {
  @override
  Future<void> addFavorites(int userId, parkingId) async {

    var url = Uri.parse(
        "${Urls.baseUrl}${Urls.apiV}user/save/favorite/$userId/$parkingId");
    var response = await http.post(url, body: null, headers: null);
    if (response.statusCode == 200) {
      print('favorites has been added ' + response.body.toString());
    } else {
      print("Opps something went wrong-------------------------------" +
          response.statusCode.toString());
      throw UnimplementedError();
    }

    // TODO: implement addFavorites
  }

  @override
  Future<List<Parking>> allFavorites(int id) async {
    List<Parking> userFavorites = [];
    var url = Uri.parse("${Urls.baseUrl}${Urls.apiV}user/all/favorites/$id");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      for (int a = 0; a < body.length; a++) {
        userFavorites.add(Parking.fromJson(body[a]));
      }

      return userFavorites;
    } else {
      throw Exception("failed to get data" + response.statusCode.toString());
    }
  }

  @override
  Future<List<Parking>> deleteFavorite(int user_id, int parking_id) async {
    List<Parking> deletedFavoriteList = [];
    //String url;
    var url = Uri.parse(
        "${Urls.baseUrl}${Urls.apiV}user/delete/favorite/$user_id/$parking_id");
    var response = await http.delete(url);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      for (int a = 0; a < body.length; a++) {
        deletedFavoriteList.add(Parking.fromJson(body[a]));
      }

      return deletedFavoriteList;
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<UserParking> activeSpot(int id) async {
    UserParking activeSpot = UserParking();

    var url = Uri.parse("${Urls.baseUrl}${Urls.apiV}user/activespot/$id");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      activeSpot = UserParking.fromJson(body);

      return activeSpot;
    } else {
      print("something went wrong oops ---" + response.statusCode.toString());
      throw UnimplementedError();
    }
  }

  @override
  Future<void> extendParkingTime(int userId, SpotAvailable extendTime) async{

     var url =Uri.parse("${Urls.baseUrl}${Urls.apiV}user/extendTime/$userId");
     var response = await http.patch(url,
         headers:{'Content-Type': 'application/json',},
         body: jsonEncode(extendTime));
     if(response.statusCode ==200){
       print(' Message : Time has been time extended');
    }else {
       print(' Message : something went wrong :${response.statusCode}');
     }

  }

  @override
  Future <UserParking> allReservedSPots(int userId) async{
    UserParking reservedSpots = UserParking();

    var url = Uri.parse("${Urls.baseUrl}${Urls.apiV}user/allReserved/$userId");

    var response = await  http.get(url);
    if(response.statusCode == 200){
      var body = json.decode(response.body);

         reservedSpots =(UserParking.fromJson(body));
      print("all reservedSPots List returned : ${response.statusCode}");

      return reservedSpots;


    }
    else{
      print("all reservedSPots List returned : ${response.statusCode}");
      throw UnimplementedError();
    }
    // TODO: implement allReservedSPots

  }

  @override
  Future<void> addReview(ReviewParking reviewParking, int userId, int parkingId) async {
   var url = Uri.parse("${Urls.baseUrl}${Urls.apiV}parking/addreview/$parkingId/$userId");
   var response =await http.patch(url, headers: { "content-Type": "application/json"},
       body: jsonEncode(reviewParking));
   if(response.statusCode ==200){
     print("Review has been succefully added : ${response.statusCode}");
   }
   else{
     print("Review was not added : ${response.statusCode}");
     throw UnimplementedError();
   }
    // TODO: implement addReview

  }


}
