import 'package:parking/models/SpotAvailable.dart';
import 'package:parking/models/parkingHistory.dart';
import 'package:parking/models/parking_model.dart';

class UserParking {
  int? id;
  String? username;
  String? profileImage;
  List<Parking>? parkingFavorites;
  List<SpotAvailable>? reservedParking;
  SpotAvailable ? bookedSpot;
  List<ParkingHistory>? bookHistory;
  ParkingHistory? bookHistoryTemp;
  bool? added;


  UserParking(
      {this.id,
        this.username,
        this.parkingFavorites,
        this.profileImage,
        this.reservedParking,
        this.bookedSpot,
        this. bookHistory,
        this.bookHistoryTemp,
        this.added});

  UserParking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    profileImage = json['profileImage'];
    if (json['parkingFavorites'] != null) {
      parkingFavorites = <Parking>[];
      json['parkingFavorites'].forEach((v) {
        parkingFavorites!.add( Parking.fromJson(v));
      });
    }
    if (json['reservedParking'] != null) {
      reservedParking = <SpotAvailable>[];
      json['reservedParking'].forEach((v) {
        reservedParking!.add(SpotAvailable.fromJson(v));
      });
    }

    bookedSpot = json['bookedSpot'] != null
        ?  SpotAvailable.fromJson(json['bookedSpot'])
        : null;

    if (json['bookHistory'] != null) {
      bookHistory = <ParkingHistory>[];
      json['bookHistory'].forEach((v) {
        bookHistory!.add(ParkingHistory.fromJson(v));
      });
    }
    added = json['added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['profileImage'] = this.profileImage;
    if (this.parkingFavorites != null) {
      data['parkingFavorites'] =
          this.parkingFavorites!.map((v) => v.toJson()).toList();
    }
    if (this.reservedParking != null) {
      data['reservedParking'] = this.reservedParking!.map((v) => v.toJson()).toList();
    }

    if (this.bookedSpot != null) {
      data['bookedSpot'] = this.bookedSpot!.toJson();
    }
    data['added'] = this.added;
    return data;
  }
}
