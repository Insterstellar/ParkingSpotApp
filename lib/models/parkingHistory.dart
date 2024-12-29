class ParkingHistory {
  int? id;
  int? duration;
  int ? parkingId ;
  double? totalPrice;
  DateTime? startDate;
  DateTime? startTime;
  DateTime? endTime;
  double? qrCodeNumber;
  String? parkingName;
  String? description;
  String? location;
  String? price;
  String? distance;
  int? numberOfSpots;

  ParkingHistory(
      {this.id,
        this.duration,
        this.parkingId,

        this.totalPrice,
        this.startDate,
        this.startTime,
        this.endTime,
        this.qrCodeNumber,
        this.parkingName,
        this.description,
        this.location,
        this.price,
        this.distance,
        this.numberOfSpots});

  ParkingHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parkingId = json['parkingId'];
    duration = json['duration'];
    startDate = json['startDate']!= null ? DateTime.parse(json['startDate']) : null;

    totalPrice = json['totalPrice'];
    startDate = json['startDate']!= null ? DateTime.parse(json['startDate']) : null;
    startTime = json['startTime']!= null ? DateTime.parse(json['startTime']) : null;
    endTime = json['endTime']!= null ? DateTime.parse(json['endTime']) : null;
    qrCodeNumber = json['qrCodeNumber'];
    parkingName = json['parkingName'];
    description = json['description'];
    location = json['location'];
    price = json['price'];
    distance = json['distance'];
    numberOfSpots = json['numberOfSpots'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parkingId'] = parkingId;
    data['duration'] = this.duration;
    data['totalPrice'] = this.totalPrice;
    data['startDate'] = this.startDate?.toIso8601String();
    data['startTime'] = this.startTime?.toIso8601String();
    data['endTime']   = this.endTime?.toIso8601String();
    data['qrCodeNumber'] = this.qrCodeNumber;
    data['parkingName'] = this.parkingName;
    data['description'] = this.description;
    data['location'] = this.location;
    data['price'] = this.price;
    data['distance'] = this.distance;
    data['numberOfSpots'] = this.numberOfSpots;
    return data;
  }
}
