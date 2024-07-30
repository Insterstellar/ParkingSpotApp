import 'package:parking/models/parking_model.dart';
import 'package:parking/repo/services/ParkingServices.dart';

class ParkingController {
  final ParkingServices _parkingServices;


  ParkingController(this._parkingServices);

  Future<List<Parking>> getAllParkingSpots () async{
    return await _parkingServices.getAllParkingSpots();
  }

   void updateParkingSpot (id, available) async{
    await _parkingServices.bookSpot(id, available);

  }
}