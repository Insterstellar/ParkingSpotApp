class SpotAvailable {
  int? id;
  bool? isOccupied;

  SpotAvailable({this.id, this.isOccupied});

  SpotAvailable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isOccupied = json['is_occupied'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_occupied'] = this.isOccupied;
    return data;
  }
}