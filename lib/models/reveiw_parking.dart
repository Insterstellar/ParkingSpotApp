import 'package:parking/models/user_parking.dart';

class ReviewParking {
  int? id;
  String? comment;
  int? stars;
  UserParking? userParkingName;

  ReviewParking({this.id, this.comment, this.stars, this.userParkingName});

  ReviewParking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    stars = json['stars'];
    userParkingName = json['userParkingName'] != null ? new UserParking.fromJson(json['userParkingName']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['stars'] = this.stars;
    if (this.userParkingName != null) {
      data['userParkingName'] = this.userParkingName!.toJson();
    }
    return data;
  }
}