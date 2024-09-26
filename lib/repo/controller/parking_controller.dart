import 'package:parking/models/parking_model.dart';
import 'package:parking/repo/services/ParkingServices.dart';

import '../../models/SpotAvailable.dart';

class ParkingController {
  final ParkingServices _parkingServices;


  ParkingController(this._parkingServices);

  Future<List<Parking>> getAllParkingSpots () async{
    return await _parkingServices.getAllParkingSpots();
  }

   void updateParkingSpot (int userId, SpotAvailable spotAvailable) async{
    await _parkingServices.bookSpot(userId,spotAvailable);

  }
}