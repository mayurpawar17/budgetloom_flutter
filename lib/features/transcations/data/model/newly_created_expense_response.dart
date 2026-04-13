class NewlyCreatedExpenseResponse {
  bool? success;
  String? message;
  Data? data;
  String? timestamp;

  NewlyCreatedExpenseResponse({
    this.success,
    this.message,
    this.data,
    this.timestamp,
  });

  NewlyCreatedExpenseResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? amount;
  String? category;
  String? createdAt;

  Data({this.id, this.title, this.amount, this.category, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    category = json['category'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['amount'] = this.amount;
    data['category'] = this.category;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
