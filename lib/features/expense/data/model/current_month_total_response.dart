class CurrentMonthTotalResponse {
  bool? success;
  String? message;
  Data? data;
  String? timestamp;

  CurrentMonthTotalResponse({
    this.success,
    this.message,
    this.data,
    this.timestamp,
  });

  CurrentMonthTotalResponse.fromJson(Map<String, dynamic> json) {
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
  double? totalExpense;

  Data({this.totalExpense});

  Data.fromJson(Map<String, dynamic> json) {
    totalExpense = json['totalExpense'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalExpense'] = this.totalExpense;
    return data;
  }
}
