import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final String? profileImage;
  final DateTime createdAt;
  final String? password; // For API compatibility

  const UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    this.profileImage,
    required this.createdAt,
    this.password,
  });

  // Factory for mock API response (gmailid, username, password, id)
  factory UserModel.fromMockApi(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['gmailid'] as String, // Mock API uses 'gmailid'
      fullName: json['username'] as String, // Mock API uses 'username'
      password: json['password'] as String?,
      profileImage: null, // Mock API doesn't have profile image
      createdAt: DateTime.now(), // Mock API doesn't have createdAt
    );
  }

  // Factory for production API response
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      profileImage: json['profileImage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      password: json['password'] as String?,
    );
  }

  // Convert to mock API format for POST requests
  Map<String, dynamic> toMockApiJson() {
    return {
      'gmailid': email,
      'username': fullName,
      'password': password,
    };
  }

  // Convert to production API format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'profileImage': profileImage,
      'createdAt': createdAt.toIso8601String(),
      if (password != null) 'password': password,
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? profileImage,
    DateTime? createdAt,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [id, email, fullName, profileImage, createdAt, password];
}
