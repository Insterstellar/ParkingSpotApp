import 'package:parking/models/Amenities.dart';
import 'package:parking/models/Gallery.dart';
import 'package:parking/models/SpotAvailable.dart';

class Parking {
  int? id;
  String? name;
  String? description;
  String? location;
  String? price;
  String? distance;
  int? numberOfSpots;
  List<SpotAvailable>? spotAvailable;
  String? coordinates;
  List<Gallery>? gallery;
  List<Amenities>? amenities;

  Parking(
      {this.id,
        this.name,
        this.description,
        this.location,
        this.price,
        this.distance,
        this.numberOfSpots,
        this.spotAvailable,
        this.coordinates,
        this.gallery,
        this.amenities});

  Parking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    location = json['location'];
    price = json['price'];
    distance = json['distance'];
    numberOfSpots = json['numberOfSpots'];
    if (json['spotAvailable'] != null) {
      spotAvailable = <SpotAvailable>[];
      json['spotAvailable'].forEach((v) {
        spotAvailable!.add(new SpotAvailable.fromJson(v));
      });
    }
    coordinates = json['coordinates'];
    if (json['gallery'] != null) {
      gallery = <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(new Gallery.fromJson(v));
      });
    }
    if (json['amenities'] != null) {
      amenities = <Amenities>[];
      json['amenities'].forEach((v) {
        amenities!.add(new Amenities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['location'] = this.location;
    data['price'] = this.price;
    data['distance'] = this.distance;
    data['numberOfSpots'] = this.numberOfSpots;
    if (this.spotAvailable != null) {
      data['spotAvailable'] =
          this.spotAvailable!.map((v) => v.toJson()).toList();
    }
    data['coordinates'] = this.coordinates;
    if (this.gallery != null) {
      data['gallery'] = this.gallery!.map((v) => v.toJson()).toList();
    }
    if (this.amenities != null) {
      data['amenities'] = this.amenities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}










