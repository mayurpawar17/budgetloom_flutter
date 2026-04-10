class CategoryExpenseResponse {
  bool? success;
  String? message;
  List<Data>? data;
  String? timestamp;

  CategoryExpenseResponse({
    this.success,
    this.message,
    this.data,
    this.timestamp,
  });

  CategoryExpenseResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Data {
  String? category;
  double? amount;

  Data({this.category, this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['amount'] = this.amount;
    return data;
  }
}
