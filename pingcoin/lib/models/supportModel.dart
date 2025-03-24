class SupportModel {
  String id = '';
  String email = '';
  String fullName = '';
  DateTime createdAt = DateTime.now();
  String message = '';

  SupportModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.createdAt,
    required this.message,
  });

  factory SupportModel.fromMap(Map<String, dynamic> map) {
    return SupportModel(id: map["id"], email: map["email"], fullName: map["fullName"], message: map["message"], createdAt: map["createdAt"].toDate());
  }

  Map<String, dynamic> toMap(){
    return {
      "id":id,
      "email":email,
      "fullName":fullName,
      "message":message,
      "createdAt":createdAt,
    };
  }
}
