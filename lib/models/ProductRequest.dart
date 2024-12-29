class ProductRequest {
  double? amount;
  int? quantity;
  String? name;
  String? currency;

  ProductRequest({this.amount, this.quantity, this.name, this.currency});

  ProductRequest.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    quantity = json['quantity'];
    name = json['name'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['quantity'] = this.quantity;
    data['name'] = this.name;
    data['currency'] = this.currency;
    return data;
  }
}
