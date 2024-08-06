import 'package:parking/models/parking_model.dart';

class UserParking {
  int? id;
  String? username;
  List<Parking>? parkingFavorites;
  bool? added;

  UserParking({this.id, this.username, this.parkingFavorites, this.added});

  UserParking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    if (json['parkingFavorites'] != null) {
      parkingFavorites = <Parking>[];
      json['parkingFavorites'].forEach((v) {
        parkingFavorites!.add(new Parking.fromJson(v));
      });
    }
    added = json['added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    if (this.parkingFavorites != null) {
      data['parkingFavorites'] =
          this.parkingFavorites!.map((v) => v.toJson()).toList();
    }
    data['added'] = this.added;
    return data;
  }
}
