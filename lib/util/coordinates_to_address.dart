import 'package:geocoding/geocoding.dart';

class AddressConverter {
  Future<String> coordinatesToAddres(String coordinatess) async {
    String location = "";
    List<String> splitedCoordinates = coordinatess.split(',');
    double latitude = double.parse(splitedCoordinates[0].trim());
    double longitude = double.parse(splitedCoordinates[1].trim());
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    var first = placemarks.first;
    location =
        "${first.street}, ${first.postalCode} ${first.subAdministrativeArea}";
    return location;
  }
}
