import 'package:parking/models/SpotAvailable.dart';
import 'package:parking/models/user_parking.dart';
import 'package:parking/repo/services/user_parking_service.dart';

import '../../models/parking_model.dart';
import '../../models/reveiw_parking.dart';

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

  Future<UserParking> activeSpot(int user_id){
    return userParkingService.activeSpot(user_id);
  }

  Future<void> extendParkingTime (int userId, SpotAvailable extendedTime)async{
    await userParkingService.extendParkingTime(userId, extendedTime);
  }

  Future<UserParking> reservedSpots (int userId)async{
    return await userParkingService.allReservedSPots(userId);
  }

  Future<void> addReview(ReviewParking reviewParking, int userId , int parkingId ) async{
    return await userParkingService.addReview(reviewParking, userId, parkingId);
  }
}