

import 'dart:async';



import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../permissions/location_permission.dart';

class CurrentPosition extends ChangeNotifier {

  Position?  _currentPosition ;
  Position?  get currentPosition =>_currentPosition;
  StreamSubscription<Position>? _positionStreamSubscription;



  Future<void> userCurrentPosition( BuildContext context) async {

    LocationsPermisionClass locationPermissions = LocationsPermisionClass();
    final hasPermission = await locationPermissions.HandleLocationPermission(context);


    if (!hasPermission) return;
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1, // Update when the position changes by 10 meters
      ),
    ).listen((Position position) {
      _currentPosition= position;
      notifyListeners(); // Notify listeners whenever the position changes
    });


  }

}