import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String email;
  final String? accessToken;
  final String? refreshToken;

  const User({
    this.id,
    required this.email,
    this.accessToken,
    this.refreshToken,
  });

  /// 🔐 From LOGIN response
  factory User.fromLoginResponse(Map<String, dynamic> json) {
    final data = json['data'];

    return User(
      email: data['email'],
      accessToken: data['accessToken'],
      refreshToken: data['refreshToken'],
    );
  }

  /// 👤 From PROFILE response
  factory User.fromProfileResponse(Map<String, dynamic> json) {
    final data = json['data'];

    return User(id: data['id'].toString(), email: data['email']);
  }

  @override
  List<Object?> get props => [id, email, accessToken, refreshToken];
}
// class User extends Equatable {
//   final String id;
//   final String email;
//
//   const User({required this.id, required this.email});
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       email: json['email'],
//       // token: json['token'], // JWT from backend
//     );
//   }
//
//   @override
//   List<Object?> get props => [id, email];
// }

// class User {
//   bool? success;
//   String? message;
//   Data? data;
//   String? timestamp;
//
//   User({this.success, this.message, this.data, this.timestamp});
//
//   User.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//     timestamp = json['timestamp'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['timestamp'] = this.timestamp;
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   String? email;
//
//   Data({this.id, this.email});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     email = json['email'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['email'] = this.email;
//     return data;
//   }
// }
