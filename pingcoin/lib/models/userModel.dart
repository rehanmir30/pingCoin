class UserModel {
  String id = "";
  String fullName = "";
  String email = "";
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
  String status = "";
  List<String> interests = [];

  UserModel(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.createdAt,
      required this.status,
      required this.interests,
      required this.updatedAt});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map["id"],
        fullName: map["fullName"],
        email: map["email"],
        createdAt: map["createdAt"].toDate(),
        status: map["status"],
        interests: List<String>.from(map["interests"] ?? []),
        updatedAt: map["updatedAt"].toDate());
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "fullName": fullName, "email": email, "createdAt": createdAt, "status": status, "interests": interests, "updatedAt": updatedAt};
  }
}
