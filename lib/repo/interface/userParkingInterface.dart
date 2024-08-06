import 'package:parking/models/user_parking.dart';

import '../../models/parking_model.dart';

abstract class UserParkingInterface {
  Future <void> addFavorites (int userId, parkingId);
  Future <List<Parking>> allFavorites (int id);
  Future<List<Parking>> deleteFavorite(int userId, int parkingId);
}