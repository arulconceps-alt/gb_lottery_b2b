import 'package:equatable/equatable.dart';

class AgentModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final int roleLevel;
  final String loginId;

  const AgentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.roleLevel,
    required this.loginId,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) {
    return AgentModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      roleLevel: json['roleLevel'] is int ? json['roleLevel'] : 0,
      loginId: json['loginId']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "role": role,
        "roleLevel": roleLevel,
        "loginId": loginId,
      };

  factory AgentModel.empty() {
    return const AgentModel(
      id: '',
      name: '',
      email: '',
      phone: '',
      role: '',
      roleLevel: 0,
      loginId: '',
    );
  }

  @override
  List<Object?> get props => [id, name, email, phone, role, roleLevel, loginId];
}
