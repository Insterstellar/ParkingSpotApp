class StripeResponse {
  String? status;
  String? message;
  String? sessionId;
  String? sessionUrl;

  StripeResponse({this.status, this.message, this.sessionId, this.sessionUrl});

  StripeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    sessionId = json['sessionId'];
    sessionUrl = json['sessionUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['sessionId'] = this.sessionId;
    data['sessionUrl'] = this.sessionUrl;
    return data;
  }
}
