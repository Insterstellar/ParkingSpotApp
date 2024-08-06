import 'package:parking/models/user_parking.dart';
import 'package:parking/repo/services/user_parking_service.dart';

import '../../models/parking_model.dart';

class UserParkingController {
  final UserParkingService userParkingService;
  UserParkingController(this.userParkingService);


  Future<void> addToFavorites (int userId, int parkingId) async{
    await userParkingService.addFavorites(userId, parkingId);

  }

  Future<List<Parking>> allFavorites (int id) {
    return  userParkingService.allFavorites(id);

  }

  Future<List<Parking>> deleteUserFavorite (int user_id, int parking_id){
    return userParkingService.deleteFavorite(user_id, parking_id);
  }
}