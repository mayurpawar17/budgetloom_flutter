class AllExpensesResponse {
  bool? success;
  String? message;
  List<Data>? data;
  String? timestamp;

  AllExpensesResponse({this.success, this.message, this.data, this.timestamp});

  AllExpensesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = timestamp;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['amount'] = amount;
    data['category'] = category;
    data['createdAt'] = createdAt;
    return data;
  }
}
