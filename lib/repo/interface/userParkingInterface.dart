import 'package:parking/models/SpotAvailable.dart';
import 'package:parking/models/reveiw_parking.dart';
import 'package:parking/models/user_parking.dart';

import '../../models/parking_model.dart';

abstract class UserParkingInterface {
  Future <void> addFavorites (int userId, parkingId);
  Future <List<Parking>> allFavorites (int id);
  Future<List<Parking>> deleteFavorite(int userId, int parkingId);
  Future<UserParking> activeSpot(int id);
  Future <void> extendParkingTime(int userId, SpotAvailable extendTime );
  Future <UserParking> allReservedSPots(int userId);
  Future<void> addReview(ReviewParking reviewParking, int userId , int parkingId);
}