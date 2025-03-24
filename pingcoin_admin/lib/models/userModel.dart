import 'package:flutter/material.dart';
class UserModel {
  String id = '';
  String fullName = '';
  String email = '';
  List<String> interests = [];
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
  String status = '';

  UserModel({required this.id,
    required this.fullName,
    required this.email,
    required this.interests,
    required this.createdAt,
    required this.updatedAt,
    required this.status});

  factory UserModel.fromMap(Map<String, dynamic>map){
    return UserModel(id: map["id"],
        fullName: map["fullName"],
        email: map["email"],
        interests: List<String>.from(map["interests"] ?? []),
        createdAt: map["createdAt"].toDate(),
        updatedAt: map["updatedAt"].toDate(),
        status: map['status']);
  }
}
