
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Place{
  final String name;
  final LatLng latLng;

  Place({required this.name, required this.latLng});

  @override
  LatLng get location => latLng;
}