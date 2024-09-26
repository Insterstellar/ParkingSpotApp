import 'package:flutter/material.dart';
import 'package:parking/models/parking_model.dart';

class SpotAvailable {
  int? id;
  bool? isOccupied;
  int? duration;
  double? totalPrice;
  DateTime? startTime;
  DateTime? endTime;
  String? remainingTime;
  Parking? parking;
  double? qrCodeNumber;


  SpotAvailable(
      {this.id,
        this.isOccupied,
        this.duration,
        this.totalPrice,
        this.startTime,
        this.endTime,
        this.remainingTime,
        this.parking,
        this.qrCodeNumber});

  SpotAvailable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isOccupied = json['is_occupied'];
    duration = json['duration'];
    totalPrice = json['totalPrice'];
    remainingTime = json['remainingTime'] ;
    startTime = json['startTime']!= null ? DateTime.parse(json['startTime']) : null;
    endTime = json['endTime']!= null ? DateTime.parse(json['endTime']) : null;
    parking = json['parking'] != null ? Parking.fromJson(json['parking']) : null;
    qrCodeNumber = json['qrCodeNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_occupied'] = this.isOccupied;
    data['duration'] = this.duration;
    data['totalPrice'] = this.totalPrice;
    data['startTime'] = this.startTime?.toIso8601String();
    data['endTime'] = this.endTime?.toIso8601String();
    if (this.parking != null) {
      data['parking'] = this.parking!.toJson();
    }
    data['qrCodeNumber'] = this.qrCodeNumber;
    return data;
  }
}





