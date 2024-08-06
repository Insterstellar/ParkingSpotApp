import 'dart:convert';

import 'package:parking/data/urls.dart';
import 'package:parking/models/user_parking.dart';
import 'package:parking/repo/interface/userParkingInterface.dart';
import 'package:http/http.dart' as http;

import '../../models/parking_model.dart';

class UserParkingService implements UserParkingInterface {
  @override
  Future<void> addFavorites(int userId, parkingId) async {
//user/save/favorite/1/2
    //String url = "user/save/favorite/1/2"
    var url = Uri.parse(
        "${Urls.baseUrl}${Urls.apiV}user/save/favorite/$userId/$parkingId");
    var response = await http.post(url, body: null, headers: null);
    if (response.statusCode == 200) {
      print('favorites has been added ' + response.body.toString());
    }
    else {
      print("Opps something went wrong-------------------------------"+response.statusCode.toString());
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
      print("succeded all favorites-------------------------------"+response.statusCode.toString());
      // List<Parking>? pt = userFavorites[0].parkingFavorites;
      return userFavorites;
    } else {

      throw Exception("failed to get data");
    }

  }

  @override
  Future<List<Parking>> deleteFavorite(int user_id, int parking_id) async{
    List<Parking> deletedFavoriteList=[];
    //String url;
    var url = Uri.parse("${Urls.baseUrl}${Urls.apiV}user/delete/favorite/$user_id/$parking_id");
    var response = await http.delete(url);
    if(response.statusCode== 200){
      var body = json.decode(response.body);
      for(int a =0; a<body.length ; a++){
        deletedFavoriteList.add(Parking.fromJson(body[a]));

      }
      print("deleted----------------------------"+response.statusCode.toString());

      return deletedFavoriteList;


    }
    else{
      print("something went wront----------------------------"+response.statusCode.toString());
      throw UnimplementedError();
    }
    // TODO: implement deleteFavorite
    throw UnimplementedError();
  }
}
