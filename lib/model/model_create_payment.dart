class ModelCreatePayment {
  String? source;
  int? amount;

  ModelCreatePayment({this.source, this.amount});

  ModelCreatePayment.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['source'] = source;
    data['amount'] = amount;
    return data;
  }
}
