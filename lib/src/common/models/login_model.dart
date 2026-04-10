import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final String userId;
  final String mobile;
  final String authToken;
  final String name;

  const LoginModel({
    required this.userId,
    required this.mobile,
    required this.authToken,
    required this.name,
  });

  LoginModel copyWith({
    String? userId,
    String? mobile,
    String? authToken,
    String? name,
  }) {
    return LoginModel(
      userId: userId ?? this.userId,
      mobile: mobile ?? this.mobile,
      authToken: authToken ?? this.authToken,
      name: name ?? this.name,
    );
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    // Handle the nested agent structure
    final agent = json['agent'] as Map<String, dynamic>?;
    
    return LoginModel(
      userId: agent?['id']?.toString() ?? json['userId']?.toString() ?? '',
      mobile: agent?['phone']?.toString() ?? json['phone']?.toString() ?? json['mobile']?.toString() ?? '',
      authToken: json['accessToken'] ?? json['authToken'] ?? '',
      name: agent?['name'] ?? json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "mobile": mobile,
        "authToken": authToken,
        "name": name,
      };

  factory LoginModel.empty() {
    return const LoginModel(
      userId: '',
      mobile: '',
      authToken: '',
      name: '',
    );
  }

  @override
  List<Object?> get props => [userId, mobile, authToken, name];
}
