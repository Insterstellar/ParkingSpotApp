import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConvertToKiloMeters {
  String changeToKilometers(LatLng startingPoint, LatLng endPoint) {
    FlutterMapMath flutterMapMath = FlutterMapMath();
    double distance = flutterMapMath.distanceBetween(
        startingPoint.latitude,
        startingPoint.longitude,
        endPoint.latitude,
        endPoint.longitude,
        "kilometers");

    return distance.toStringAsFixed(1).toString();
  }
}
