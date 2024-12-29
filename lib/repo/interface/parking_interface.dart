import 'dart:ffi';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking/models/parking_model.dart';

import '../../models/SpotAvailable.dart';

abstract class ParkingInterface{
   Future <List<Parking>> getAllParkingSpots ();
   Future <Parking> saveParkingSpots (Parking saveParking);
   Future <SpotAvailable> bookSpot (int userId,SpotAvailable spotAvailable);
   Future <List<Map<String, dynamic>>> getPublicSpots (LatLng latLng);
}