import 'dart:ffi';

import 'package:parking/models/parking_model.dart';

import '../../models/SpotAvailable.dart';

abstract class ParkingInterface{
   Future <List<Parking>> getAllParkingSpots ();
   Future <Parking> saveParkingSpots (Parking saveParking);
   Future <SpotAvailable> bookSpot (int id , bool available );
}